//
//  NotesListModel.swift
//  Nofyme
//
//  Created by s b on 17.08.2022.
//

import Foundation

class NoteModel: Codable {
    
    var name: String
    var desc: String?
    var creationTime: Date
    var notificationTime : Date?
    
    init(name: String, desc: String? = nil, notificationTime: Date? = nil) {
        self.name = name
        self.desc = desc
        self.creationTime = Date()
        self.notificationTime = notificationTime
        
    }
}
