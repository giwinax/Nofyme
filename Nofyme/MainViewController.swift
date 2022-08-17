//
//  UiViewController.swift
//  Nofyme (iOS)
//
//  Created by s b on 17.08.2022.
//

import UIKit
import SnapKit

class MainViewController: UITableViewController {
    
    let storage = Storage()
    var notes = [NoteModel(name: "ASD"), NoteModel(name: "FGGH")] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var addButton: UIButton = {
        let bt = UIButton()
        
        bt.setAttributedTitle(NSAttributedString(string: "+", attributes: [.font: UIFont.systemFont(ofSize: 72), .foregroundColor : UIColor.systemBlue]), for: .normal)
        bt.setAttributedTitle(NSAttributedString(string: "+", attributes: [.font: UIFont.systemFont(ofSize: 72, weight: .thin), .foregroundColor : UIColor.systemGray]), for: .highlighted)
        
        bt.addTarget(self, action: #selector(addNew), for: .touchUpInside)
        
        return bt
    }()
    
    @objc func addNew() {
        let alert = UIAlertController(title: "Новое напоминание", message: "Введите напоминание", preferredStyle: .alert)
        addAlertWithTextField(textFieldtext: "Купить ", alert: alert) { [weak self] (_) in
            
            let textFieldtext = alert.textFields![0].text!
            
            let newNote = NoteModel(name: textFieldtext)
            
            self!.storage.addToPersistance(note: newNote)
            self!.notes.append(newNote)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
#warning("Need to uncomment")
        self.notes = storage.notes
        
        self.view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerX.equalToSuperview().multipliedBy(1.66666)//.offset(-30)
            make.centerY.equalToSuperview().multipliedBy(1.66666)//.offset(30)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        storage.removeFromPersistance(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in
            
            let alert = UIAlertController(title: "Изменить описание", message: "Введите описание напоминания", preferredStyle: .alert)
            self.addAlertWithTextField(textFieldtext: "", alert: alert) { (_) in
                
                let textFieldtext = alert.textFields![0].text!
                
                let currentNote = self.notes[indexPath.row]
                
                let newNote = NoteModel(name: currentNote.name, desc: textFieldtext, notificationTime: nil)
                
                self.storage.updateInPersistance(at: indexPath.row, newNote)
                
                self.notes[indexPath.row] = newNote
            }
            completionHandler(true)
        }
        
        editAction.backgroundColor = UIColor.systemBlue
        editAction.image = UIImage(systemName: "info.circle")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [editAction])
        
        return swipeConfiguration
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoteViewController()
        
        vc.configure(note: notes[indexPath.row])
        
        vc.storage = self.storage
        
        vc.noteI = indexPath.row
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notes[indexPath.row].name
        return cell
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct MainViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        
        MainViewController().showPreview()
    }
}
#endif
