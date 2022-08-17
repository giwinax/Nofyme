//
//  NoteView.swift
//  Nofyme (iOS)
//
//  Created by s b on 17.08.2022.
//

import UIKit
import SnapKit

class NoteViewController: UIViewController {
    
    var note: NoteModel!
    var noteI: Int!
    weak var storage: Storage!
    var notifications = Notifications()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = .magenta
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            descLabel])
        stackView.axis = .vertical
        stackView.spacing = 4.0
        return stackView
    }()
    
    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.locale = Locale(identifier: "ru")
        dp.addTarget(self, action: #selector(setNoteTime), for: .editingDidEnd)
        dp.date = self.note.notificationTime ?? Date()
        return dp
    }()
    
    lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textStackView, datePicker])
        stackView.axis = .horizontal
        stackView.spacing = 16.0
        stackView.alignment = .center
        return stackView
    }()
    
    @objc func setNoteTime(_ sender: UIDatePicker) {
        
        let newNote = NoteModel(name: self.note.name, desc: self.note.desc, notificationTime: sender.date)
    
        storage.updateInPersistance(at: self.noteI, newNote)
        
        self.notifications.addNotification(at: sender.date, name: newNote.name, desc: newNote.desc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupView()
    }
    
    func setupView() {
        self.view.addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        configure(note: NoteModel(name: "Купить капли для глаз", desc: "Визин", notificationTime: Date(timeIntervalSinceNow: 60)))
    }
    
    func configure(note: NoteModel) {
        self.note = note
        self.nameLabel.text = note.name
        self.descLabel.text = note.desc
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct NoteViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        
        NoteViewController().showPreview()
    }
}
#endif
