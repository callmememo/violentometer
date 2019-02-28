//
//  ViewController.swift
//  violentometro
//
//  Created by Memo Rodriguez on 2/27/19.
//  Copyright © 2019 Guillermo Rodriguez. All rights reserved.
//

import UIKit

class ViolentometerViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var questions = [
        Question(question: "Bromas hirientes", level: .one),
        Question(question: "Chantajear", level: .one),
        Question(question: "Mentir, Engañar", level: .one),
        Question(question: "Ignorar/Ley del hielo", level: .one),
        Question(question: "Culpabilizar", level: .one),
        Question(question: "Descalificar", level: .one),
        Question(question: "Ridiculizar/Ofender", level: .one),
        Question(question: "Humillar en publico", level: .two),
        Question(question: "Intimidar / amenazar", level: .two),
        Question(question: "Controlar / Prohibir", level: .two),
        Question(question: "Destruir articulos personales", level: .three),
        Question(question: "Caricias agresivas", level: .three),
        Question(question: "Golpear jugando", level: .three),
        Question(question: "Pelliscar arañar", level: .three),
        Question(question: "Empujar jalonear", level: .four),
        Question(question: "Cachetear", level: .four),
        Question(question: "Patear", level: .four),
        Question(question: "Encerrar, aislar", level: .four),
        Question(question: "Amenazar con objetos o armas", level: .four),
        Question(question: "Abuso sexual", level: .five),
        Question(question: "Violar", level: .five),
        Question(question: "Mutilar", level: .five),
        ]
    
    var violentometerLevel: Level = .one
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = false
        collectionView.register(ViolentometerCell.self, forCellWithReuseIdentifier: "Cell")
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    func nextQuestion(question: Question, answer: Answer) {
        guard let currentCell = collectionView.visibleCells.first as? ViolentometerCell,
            let indexPath = collectionView.indexPath(for: currentCell) else { return }
        let newIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
        if answer == .yes {
            self.violentometerLevel = question.level
        }
        guard questions.count != newIndexPath.row else {
            
            var title: String!
            var message = ""
            
            switch violentometerLevel {
            case .one:
            title = "¡Cuéntaselo a alguien de tu confianza y ten cuidado que esto puede aumentar!"
            case .two: title = "¡Cuéntaselo a alguien de tu confianza y si puedes alejate!"
            case .three:
                title = "¡Reacciona! Te sugerimos acudir a:"
                message = "CAP\nCOPAVIDE"
            case .four:
                title = "¡Reacciona y no te calles! ¡Pide ayuda!Te sugerimos acudir a:"
                message = "COPAVIDE\nCAP\nCentro de Salud Nueva Morelos\nFacultad de Psicología UANL\nIEM"
            case .five:
                title = "¡Peligro! ¡Pide ayuda y actúa ya! Te sugerimos ir a:"
                message = "Agencia del Ministerio Público\nCOPAVIDE Monterrey\nCAIPA\nFacultad de Psicología UANL\nComisión Ejecutiva Estatal de Atención a Víctimas\nIEM"
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
            DispatchQueue.main.async {
             self.present(alert, animated: true, completion: nil)
            }
            return
        }
        collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ViolentometerCell
        cell.configureCell(question: questions[indexPath.row], viewController: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

