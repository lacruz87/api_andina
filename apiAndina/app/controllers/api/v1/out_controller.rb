class Api::V1::OutController < ApplicationController


  def getRfidInfo
  	begin

	  	r_rfid=tag_params['rfid']
	  	r_sku="000000"
	  	r_desc="SIN INFO"
	  	r_cjxpal=0

	  	tag=Tag.find_by_rfid(tag_params['rfid'])


		unless tag
	        #tag = Tag.new(tag_params)
	  		#product=Product.all.sample
	     	#tag.product=product
	     else
	  		product=tag.product
		  	r_sku=product.sku
		  	r_desc=product.desc
		  	r_cjxpal=product.cjxpallet 
	     end
         tag.save

		  response=Hash.new
		  response[:rfid] = r_rfid
		  response[:sku] = r_sku
		  response[:desc] = r_desc
		  response[:cjxpallet] = r_cjxpal    

	rescue StandardError => error
	  # code that deals with some exception
	  response_error=error
	  success=false
	else
	  # code that runs only if *no* exception was raised
	  success=true

	ensure
	  # ensure that this code always runs, no matter what
	  # does not change the final value of the block
	end

	output=standardResponseHash(success,response,response_error).to_json
	render :json=>output
  end

  def getStock
  	begin

  		response = Product.all

	rescue StandardError => error
	  # code that deals with some exception
	  response_error=error
	  success=false
	else
	  # code that runs only if *no* exception was raised
	  success=true

	ensure
	  # ensure that this code always runs, no matter what
	  # does not change the final value of the block
	end

	output=standardResponseHash(success,response,response_error).to_json
	render :json=>output

  end

  def getPointZona
  	begin

    lat=zona_params['lat'].to_f
    lng=zona_params['lng'].to_f


    if (lat==nil || lng==nil) then
    	raise "Valor nulo Lat o Lng "
    end
    
    srid=4326
    zonas=Zona.where("ST_Intersects(geom, ST_Transform(ST_GeomFromText('POINT(? ?)',4326),?))",lng,lat,srid)

    if (zonas.count<1) then
    	raise "No se encontró ninguna zona "
    elsif(zonas.count==1) then
    	zona=zonas
    else
    	zona=zonas[0]
    end

    feature_collection = Zona.to_feature_collection zona
   	response= leoJson(RGeo::GeoJSON.encode(feature_collection))


	rescue StandardError => error
	  # code that deals with some exception
	  response_error=error
	  success=false
	else
	  # code that runs only if *no* exception was raised
	  success=true

	ensure
	  # ensure that this code always runs, no matter what
	  # does not change the final value of the block
	end

	output=standardResponseHash(success,response,response_error).to_json
	render :json=>output
  end

  def getZona

  	begin

	  	zonas=Zona.where("name=?",zona_name_params['name'])

		if (zonas.count<1) then
	        raise "No se encontró ninguna zona con el nombre"+ zona_name_params['name'].to_s
	    elsif(zonas.count==1) then
	    	zona=zonas
	    else
	    	zona=zonas[0]	  		
	     end

	    feature_collection = Zona.to_feature_collection zona

	   	response= leoJson(RGeo::GeoJSON.encode(feature_collection))

	rescue StandardError => error
	  # code that deals with some exception
	  response_error=error
	  success=false
	else
	  # code that runs only if *no* exception was raised
	  success=true

	ensure
	  # ensure that this code always runs, no matter what
	  # does not change the final value of the block
	end

	output=standardResponseHash(success,response,response_error).to_json
	render :json=>output

  end


  def getZonas

  	begin

	  	zonas=Zona.all
	    feature_collection = Zona.to_feature_collection zonas

		response=leoJson(RGeo::GeoJSON.encode(feature_collection))

	rescue StandardError => error
	  # code that deals with some exception
	  response_error=error
	  success=false
	else
	  # code that runs only if *no* exception was raised
	  success=true

	ensure
	  # ensure that this code always runs, no matter what
	  # does not change the final value of the block
	end

	output=standardResponseHash(success,response,response_error).to_json
	render :json=>output

  end

      # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.permit(:rfid)
    end

  def zona_params
    params.permit(:lat,:lng)
  end

  def zona_name_params
    params.permit(:name)
  end

 def standardResponseHash(_success,_data,_error)
  data=Hash.new
  data[:success] = _success
  data[:data] = _data
  data[:error] = _error      
  return data
end

def leoJson(geoJson)
  data_hash=Hash.new
  features_hash = JSON.parse('{"features" : []}');
 
  data_hash[:type] = geoJson["type"] 
  features = geoJson["features"] 

	features.each do |feature|
		feature_hash=Hash.new
		feature_hash[:type]=feature["type"]
		geometry_hash = JSON.parse('{"coordinates" : []}');
		geometry_hash[:type]=feature["geometry"]["type"]
		geometry_hash[:color]=feature["properties"]["color"]
		coordinates=feature["geometry"]["coordinates"]
		coordinates[0][0].each do |coordinate|
			coordinate_hash=Hash.new
			coordinate_hash[:lat]=coordinate[1]
			coordinate_hash[:lng]=coordinate[0]
			geometry_hash["coordinates"] << coordinate_hash
		end

		geometry_hash[:coordinates]
		feature_hash[:geometry]=geometry_hash
		feature_hash[:properties]=feature["properties"]
		feature_hash[:id]=feature["id"]
		features_hash["features"] << feature_hash
	end
	
	data_hash[:features]=features_hash
  return data_hash
end


end
