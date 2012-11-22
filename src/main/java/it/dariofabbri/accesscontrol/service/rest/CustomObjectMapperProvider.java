package it.dariofabbri.accesscontrol.service.rest;

import java.text.SimpleDateFormat;

import javax.ws.rs.ext.ContextResolver;
import javax.ws.rs.ext.Provider;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

@Provider
public class CustomObjectMapperProvider implements ContextResolver<ObjectMapper> {

    private final ObjectMapper mapper = new ObjectMapper();

    public CustomObjectMapperProvider() {
		
    	SerializationConfig sc = mapper.getSerializationConfig();
    	mapper.setSerializationConfig(sc.withDateFormat(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX")));
    	
    	DeserializationConfig dc = mapper.getDeserializationConfig();
    	mapper.setDeserializationConfig(dc.withDateFormat(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX")));
	}

	@Override
	public ObjectMapper getContext(Class<?> type) {
		return mapper;
	}
}
