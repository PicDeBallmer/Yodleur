module LieuxHelper

  def self.lieux_select
    Lieu.all.collect { |l| [l.nom, l.id] }
  end

end