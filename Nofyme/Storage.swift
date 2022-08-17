//
//  Storage.swift
//  Nofyme
//
//  Created by s b on 17.08.2022.
//

import Foundation

struct DefaultsKeys {
    static let note = "noteKey"
}

let localStorage = UserDefaults.standard

//TODO: IDs instead of indexes

class Storage {
        func addToPersistance(note: NoteModel) {
            
            var notesStorageArray = localStorageRetrieve()
            
            notesStorageArray.append(note)
         
            localStorageSet(notesStorageArray)
        }
        
        func removeFromPersistance(at i: Int) {
            
            var notesStorageArray = localStorageRetrieve()
            
            notesStorageArray.remove(at: i)
            
            localStorageSet(notesStorageArray)
        }
        
        func updateInPersistance(at i: Int, _ note: NoteModel) {
            
            var notesStorageArray = localStorageRetrieve()
            notesStorageArray[i] = note
            
            localStorageSet(notesStorageArray)
        }
        
        func note(at i: Int) -> NoteModel {
            let notesStorageArray = localStorageRetrieve()
           
            return notesStorageArray[i]
            
        }
        
        var notes: [NoteModel] {
            return localStorageRetrieve()
        }
        
        var notesCount: Int {
            let notesStorageArray = localStorageRetrieve()
            
            return notesStorageArray.count
        }
    
    private func localStorageSet(_ a: [NoteModel]) {
        do
        {
            let encodedData = try PropertyListEncoder().encode(a)
            localStorage.set(encodedData, forKey: DefaultsKeys.note)
        }
        catch
        {
            print("error in \(#function)")
        }
    }
    
    private func localStorageRetrieve() -> [NoteModel] {
        let decoded = UserDefaults.standard.object(forKey: DefaultsKeys.note) as! Data
        do
        {
            let decodedNotes = try PropertyListDecoder().decode([NoteModel].self, from: decoded) 
            return decodedNotes
        }
            catch
            {
                print("error in \(#function)")
            }
            return [NoteModel]()
        }
    }
