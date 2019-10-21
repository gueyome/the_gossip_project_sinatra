class Gossip
  attr_accessor :content, :author

  def initialize(author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "a+") do |csv|
      csv << [@author, @content]
    end 
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(index)
    return Gossip.all[index]
  end

  def self.update(index, gossip_new)
    # Créer une liste physique à manipuler qui va stocker tous les gossips
    intermediate_list = Gossip.all
    # Modification de l'élément dans la liste
    intermediate_list[index] = gossip_new
    # On efface le csv et le ré-écrit
    CSV.open('./db/gossip.csv','w')
    intermediate_list.each { |element| element.save }
  end

end