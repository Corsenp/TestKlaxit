//
//  ProfileViewController.swift
//  TestKlaxit
//
//  Created by Pierre Corsenac on 24/03/2022.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var corporationName: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobName: UITextField!
    @IBOutlet weak var homeAddress: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    private var currentProfile = [Profile]()
    private let apiCaller = Service()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumber.delegate = self
        corporationName.delegate = self
        jobName.delegate = self
        homeAddress.delegate = self
        createProfile()
        
        setupLabels()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let profile = currentProfile.first {
            updateProfileAddress(profile: profile, address: homeAddress.text ?? "")
        }
    }
    
    private func setupImage(url: String) {
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        ImageFetcher.shared.fetchImage(url: url) { [weak self] image in
            DispatchQueue.main.async() { [weak self] in
                self?.profileImage.image = image
            }
        }
    }
    
    func createProfile() {
        let profile = Profile(context: context)

        do {
            let request = try context.fetch(Profile.fetchRequest())
            let count = request.count
            if count <= 1 {
                guard let localData = apiCaller.readLocalProfile(forName: "account") else {return}
                
                profile.first_name = localData.first_name
                profile.last_name = localData.last_name
                profile.company = localData.company
                profile.job_position = localData.job_position
                profile.picture_URL = localData.picture_url
                profile.phone_number = localData.phone_number
                try context.save()
            }
        } catch {
            print("Error Fetching/saving Core Data Profile")
            return
        }
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let profile = currentProfile.first {
            updateProfileJob(profile: profile, job: jobName.text ?? "")
            updateProfileNumber(profile: profile, number: phoneNumber.text ?? "")
            updateProfileAddress(profile: profile, address: homeAddress.text ?? "")
            updateProfileCompany(profile: profile, company: corporationName.text ?? "")
        }
        return true
    }
    
    func setupLabels() {
        do {
            currentProfile = try context.fetch(Profile.fetchRequest())
            
            phoneNumber.text = currentProfile.first?.phone_number
            homeAddress.text = currentProfile.first?.address
            corporationName.text = currentProfile.first?.company
            jobName.text = currentProfile.first?.job_position
            if let firstName = currentProfile.first?.first_name, let lastName = currentProfile.first?.last_name {
                nameLabel.text = firstName + " " + lastName
            }
            if let url = currentProfile.first?.picture_URL {
                setupImage(url: url)
            }
        } catch {
            print("Error Setting up Label")
        }
        
    }
    
    func updateProfileNumber(profile: Profile, number: String) {
        profile.phone_number = number
        do {
            try context.save()
        } catch {
            print("Error Updating Profile Number")
        }
    }
    
    func updateProfileCompany(profile: Profile, company: String) {
        profile.company = company
        do {
            try context.save()
        } catch {
            print("Error Updating Profile Company")
        }
    }
    
    func updateProfileJob(profile: Profile, job: String) {
        profile.job_position = job
        do {
            try context.save()
        } catch {
            print("Error Updating Profile Job")
        }
    }
    
    func updateProfileAddress(profile: Profile, address: String) {
        profile.address = address
        do {
            try context.save()
        } catch {
            print("Error Updating Address")
        }
    }
}
