//
//  CreateTinyUrlViewController.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateTinyUrlViewController: UIViewController {

    private var viewModel =  CreateTinyUrlViewModel(networkingService: TinyUrlApi())
    @IBOutlet var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.topItem!.title = ""
        
        SVProgressHUD.setBackgroundColor(.orange)
        SVProgressHUD.setForegroundColor(.white)
        
        self.setupViewModel()
    }
    
    private func setupViewModel() {

        viewModel.isRefreshing = { loading in
            SVProgressHUD.show()
        }
        viewModel.didTransformUrl = { [weak self] success in
            guard let strongSelf = self else { return }
            SVProgressHUD.showSuccess(withStatus: "Linked shortened and copied on clipboard")
            sleep(2)
            strongSelf.navigationController?.popViewController(animated: true)
        }
        
        viewModel.hasError = { [weak self] error in
             guard let strongSelf = self else { return }
            let alertController = UIAlertController(title: "TinyUrl", message: error, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            strongSelf.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func transformUrlAction(_ sender: Any) {
        // check not empty
        // check if valid url
        //
        viewModel.transformUrl(self.urlTextField.text!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
