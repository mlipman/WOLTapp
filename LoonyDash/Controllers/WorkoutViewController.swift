//
//  WorkoutViewController.swift
//  LoonyDash
//
//  Created by Kris Aldenderfer on 6/8/15.
//  Copyright (c) 2015 LooneyDash. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var workout: Workout!
    var workoutSets: [WorkoutSet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        
        self.navigationItem.title = self.workout.title
        
        refreshData()
    }
    
    func refreshData() {
        DashClient.sharedInstance.fetchWorkoutSetsForWorkout (workout) { (workoutSets, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                for workoutSet in workoutSets {
                    workoutSet.numReps = workoutSet.numSuggestedReps
                }
                self.workoutSets = workoutSets
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutSets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("WorkoutSetCell") as! WorkoutSetCell
        cell.workoutSet = self.workoutSets?[indexPath.row]
        
        return cell
    }
    
    @IBAction func onBeginWorkout(sender: AnyObject) {
        let story = UIStoryboard(name: "Sets", bundle: nil)
        let setsVC = story.instantiateViewControllerWithIdentifier("SetViewController") as! SetViewController
        setsVC.workout = self.workout
        setsVC.workoutSets = self.workoutSets
        self.navigationController!.pushViewController(setsVC, animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
    
}
