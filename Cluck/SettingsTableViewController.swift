//
//  SettingsTableViewController.swift
//  Cluck
//
//  Created by Вячеслав Рожнов on 30.08.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
  @IBOutlet weak var newQuestionSwitch: UISwitch!
  @IBOutlet weak var newCluckSwitch: UISwitch!
  @IBOutlet weak var newResponseSwitch: UISwitch!
  @IBOutlet weak var soundSwitch: UISwitch!
  @IBOutlet weak var vibrationSwitch: UISwitch!
  
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    newQuestionSwitch.setOn(UserDefaults.standard.bool(forKey: "newQuestion"), animated: true)
    newCluckSwitch.setOn(UserDefaults.standard.bool(forKey: "newCluckS"), animated: true)
    newResponseSwitch.setOn(UserDefaults.standard.bool(forKey: "newResponse"), animated: true)
    soundSwitch.setOn(UserDefaults.standard.bool(forKey: "sound"), animated: true)
    vibrationSwitch.setOn(UserDefaults.standard.bool(forKey: "vibration"), animated: true)
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if section == 0 {
      return 3
    }
    else {
      return 2
    }
    
  }
  
  @IBAction func tapSwitch(_ sender: UISwitch, forEvent event: UIEvent) {
    let UserDefaultsStandard = UserDefaults.standard
    switch sender {
    case newQuestionSwitch:
      UserDefaultsStandard.set(newQuestionSwitch.isOn, forKey: "newQuestion")
      break
    case newCluckSwitch:
      UserDefaultsStandard.set(newCluckSwitch.isOn, forKey: "newCluckS")
      break
    case newResponseSwitch:
      UserDefaultsStandard.set(newResponseSwitch.isOn, forKey: "newResponse")
      break
    case soundSwitch:
      UserDefaultsStandard.set(soundSwitch.isOn, forKey: "sound")
      break
    case vibrationSwitch:
      UserDefaultsStandard.set(vibrationSwitch.isOn, forKey: "vibration")
      break
    default:
      break
    }
  }
  
  /*
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
   
   // Configure the cell...
   
   return cell
   }
   */
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
