//
//  TransactionTableViewController.swift
//  ASBInterviewExercise
//
//  Created by DonorRaja on 3/06/22.
//

import UIKit

class TransactionTableViewController: UITableViewController {
    
    
    //MARK: - Variables
    var transactions = [Transaction]()
    var currentTransactions: [String:[Transaction]] = [:]
    var transactionList:[String] = [String]()
    
   //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTransactionDataRequest()
    }
    
    //MARK: - Functions
    
    func getTransactionDataRequest() {
        
        if let url = URL(string: ASB.API.apiURL) {
               if let data = try? Data(contentsOf: url) {

                   let decoder = JSONDecoder()

                       if let jsonData = try? decoder.decode([Transaction].self, from: data) {
                           print(jsonData)
                           self.transactions = jsonData
                           
                           for (key,value) in self.transactions.enumerated() {
                               self.transactions[key].transactionDate = Utility.convertDateFormater(value.transactionDate)
                               
                           }
                           self.currentTransactions = Dictionary(grouping: self.transactions, by: { $0.transactionDate })
                           
                       }else {
                           print("error")
                           
                       }
               }
           }
    }
    
    func getLists() {
        transactionList = Array(currentTransactions.keys)
        let df = DateFormatter()
        df.dateFormat = "d MMM yyyy"
        transactionList = transactionList.sorted {df.date(from: $0)! > df.date(from: $1)!}
        print(transactionList)
    
    }
    
    func getNumberOfEntrysInSection (Section: Int) -> Int {
        let transaction:String = self.transactionList[Section]
        let value:[Transaction] = currentTransactions[transaction]!
        return value.count
    }
    
    func requestForTransactionList(indexPath: IndexPath) -> [Transaction] {
        let sectionList = self.transactionList[indexPath.section]
         let rowsList = self.currentTransactions[sectionList]
        return rowsList!
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        self.getLists()
        return self.transactionList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getNumberOfEntrysInSection(Section: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return transactionList[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell

        let rowsList = self.requestForTransactionList(indexPath: indexPath)
        
        // Configure the cell...
        let transactionData = rowsList[indexPath.row]
        cell.transactionName.text = transactionData.summary
        
        var detailText = ""
        if transactionData.credit != 0 {
            detailText = "+ \(transactionData.credit)"
            cell.transactionAmount.textColor = .green
        }else {
            detailText = "- \(transactionData.debit)"
            cell.transactionAmount.textColor = .red
        }
        cell.transactionAmount.text = detailText

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "sendDataSegue", sender: indexPath)
    }

   
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDataSegue" {
            let indexPath = sender as! IndexPath
            let vc = segue.destination as! TransactionDetailsViewController
            let rowsList = self.requestForTransactionList(indexPath: sender as! IndexPath)
            let transactionDetail = rowsList[indexPath.row]
            vc.transactionDetails = transactionDetail
        }
    }
   
}
