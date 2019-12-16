//
//	ViewController.swift
//	NamedView-ios
//
//	Created by Kaz Yoshikawa on 12/16/19.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let cyanView = self.view.view(named: "cyan")
		let magentaView = self.view.view(named: "magenta")
		let yellowView = self.view.view(named: "yellow")
		cyanView?.backgroundColor = UIColor.cyan
		magentaView?.backgroundColor = UIColor.magenta
		yellowView?.backgroundColor = UIColor.yellow
	}


}

