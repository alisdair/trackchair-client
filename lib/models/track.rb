class Track < Model
  attr_accessor :id, :title, :description, :position

  def <=>(track)
    position <=> track.position
  end
end
