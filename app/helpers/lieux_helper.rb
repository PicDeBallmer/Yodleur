module LieuxHelper

  def self.lieux_select
  #  Lieu.all.collect { |l| [l.nom, l.id] }
    [Lieu.new({nom: "Lyon", id: 1}),
     Lieu.new({nom: "Villeurbanne", id: 2})]
        .collect { |l| [l.nom, l.id] }
  end

end