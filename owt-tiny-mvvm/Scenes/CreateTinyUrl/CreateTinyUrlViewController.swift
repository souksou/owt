//
//  CreateTinyUrlViewController.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit

class CreateTinyUrlViewController: UIViewController {

    private var viewModel =  CreateTinyUrlViewModel(networkingService: TinyUrlApi())
    @IBOutlet var urlTextField: UITextField!
    
    
    
    // use this for dependency injection
//    init(viewModel: CreateTinyUrlViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewModel()
    }
    
    private func setupViewModel() {

        viewModel.isRefreshing = { loading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
        viewModel.didTransformUrl = { [weak self] success in
            guard let strongSelf = self else { return }
            strongSelf.navigationController?.popViewController(animated: true)
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
