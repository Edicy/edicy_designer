class MediaSetDrop < Liquid::Drop
  
  def initialize(mediaset)
    @mediaset = mediaset
  end
  
  def title
    @mediaset.title
  end
  
  def photos
    @photos ||= begin
      assets = @mediaset.assets_media_sets.all(:include => {:asset => :thumbnails})
      assets.inject(Array.new) do |a, asset|
        a << AssetDrop.new(asset) if asset.asset && asset.asset.image?
        a
      end
    end
  end
  
  def assets
    @assets ||= begin
      assets = @mediaset.assets_media_sets.all(:include => {:asset => :thumbnails})
      assets.inject(Array.new) do |a, asset|
        a << AssetDrop.new(asset) if asset.asset
        a
      end
    end
  end
end