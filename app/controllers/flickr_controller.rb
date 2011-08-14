class FlickrController < ApplicationController  
  def search
     FlickRaw.api_key="####"
     FlickRaw.shared_secret="#####"
	 
	 #render :partial => "photo.html", 
	 #       :collection => getSizes(params[:tags])
	 
	 if params[:tags] != "" 
	   render :inline => getIMGs(params[:tags], params[:per_page])
	 else 
	   render :inline => "No matches, try again."
	 end 
  end

  def getIMGs(tags, maxPerPage)
    result = flickr.photos.search(:tags => tags, :per_page => maxPerPage)
	html = ""
    result.each do |photo|
	    sizes = flickr.photos.getSizes(:photo_id => photo.id) 
		html = html + getPhoto(sizes)
	end
	return html
  end
  
  def getPhoto(sizes)
    html = "<a href='" + sizes.size[2].url + "' target='_blank'><img class='photo' src='" + sizes.size[2].source + "'/></a>"
  end
  
#  def getSizes(tags)
#    result = flickr.photos.search(:tags => tags, :per_page => '16')
#	sizes =  flickr.photos.getSizes(:photo_id => result.photo[8]['id']) 
#    return sizes	#sizes.size[0].source
#  end

end
