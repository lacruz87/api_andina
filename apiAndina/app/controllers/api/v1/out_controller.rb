class Api::V1::OutController < ApplicationController


  def getRfidInfo
  	begin

	  	tag=Tag.find_by_rfid(tag_params['rfid'])

		unless tag
	        tag = Tag.new(tag_params)
	  		product=Product.all.sample
	     	tag.product=product
	     else
	  		product=tag.product
	     end
         tag.save

		  response=Hash.new
		  response[:rfid] = tag.rfid
		  response[:sku] = product.sku
		  response[:desc] = product.desc
		  response[:cjxpallet] = product.cjxpallet    

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
   	response= RGeo::GeoJSON.encode(feature_collection)


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

	   	response= RGeo::GeoJSON.encode(feature_collection)

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

		response=RGeo::GeoJSON.encode(feature_collection)

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


end
