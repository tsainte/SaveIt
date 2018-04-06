//
//  BanksViewController.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 01/03/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import UIKit

class BanksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = BanksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension BanksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankTableViewCell", for: indexPath) as! BankTableViewCell
        
        let row = indexPath.row
        
        cell.delegate = self
        cell.logo.image = UIImage(named: viewModel.logo(for: row))
        cell.bankName.text = viewModel.name(for: row)
        cell.status.isOn = viewModel.status(for: row)
        
        return cell
    }
}

// actions
extension BanksViewController: BankTableViewCellDelegate {
    func statusSwitchDidChange(cell: BankTableViewCell, to status: Bool) {
        guard let row = tableView.indexPath(for: cell)?.row else { return }
        viewModel.newStatus(for: row, status: status)
    }
}
