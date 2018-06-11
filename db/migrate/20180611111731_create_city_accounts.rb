class CreateCityAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :city_accounts do |t|
      t.string :code_commune
      t.integer :invest_ress_emprunts
      t.integer :dette_encours_total
      t.integer :invest_empl_charges
      t.integer :taxe_professionnelle
      t.integer :dette_annuite
      t.integer :invest_ress_subventions
      t.integer :cap_autofinancement_nette
      t.integer :avance_tresor
      t.integer :invest_ress_fctva
      t.integer :prod_autres_impots_taxes
      t.integer :invest_empl_equipements
      t.integer :produits_total
      t.integer :taxe_habitation
      t.integer :invest_empl_immobilisations
      t.integer :invest_ressources_total
      t.integer :invest_empl_remboursement_emprunts
      t.integer :charges_total
      t.integer :charges_personnel
      t.integer :resultat_comptable
      t.integer :prod_dotation
      t.integer :charges_achats
      t.integer :taxe_non_bati
      t.integer :annee
      t.integer :taxe_foncier_bati
      t.integer :charges_financieres
      t.integer :charges_subventions
      t.integer :excedent_brut
      t.integer :charges_contingents
      t.integer :invest_emplois_total
      t.integer :invest_ress_retours
      t.integer :cap_autofinancement
      t.integer :fond_de_roulement

      t.timestamps
    end
    add_index :city_accounts, :code_commune
  end
end
