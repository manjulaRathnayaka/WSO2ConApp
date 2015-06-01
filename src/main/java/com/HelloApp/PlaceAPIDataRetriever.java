package com.HelloApp;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.wso2.carbon.context.CarbonContext;
import org.wso2.carbon.context.RegistryType;
import org.wso2.carbon.registry.core.Registry;
import org.wso2.carbon.registry.core.Resource;
import org.wso2.carbon.registry.core.exceptions.RegistryException;
import se.walkercrou.places.GooglePlaces;
import se.walkercrou.places.Place;

public class PlaceAPIDataRetriever {
	private static Log log = LogFactory.getLog(PlaceAPIDataRetriever.class);

	public List<Place> searchPlace(String place){
		String applicationName = "mytravellog";
		String googleAPIKey = getGoogleAPIKey(applicationName);
		if (googleAPIKey == null) {
			googleAPIKey = "AIzaSyA6PwPjtTEkzTNrU09BFkYtct2E9CovVYM";
		}

		GooglePlaces googlePlaceClient = new GooglePlaces(googleAPIKey);
		return googlePlaceClient.getPlacesByQuery(place, 5);

	}

	private String getGoogleAPIKey(String applicationKey){
		String propValue = null;
		String resourcePath = "/dependencies/"+applicationKey+"/googleAPIKey";
		CarbonContext cCtx = CarbonContext.getThreadLocalCarbonContext();
		Registry registry = (Registry) cCtx.getRegistry(RegistryType.SYSTEM_GOVERNANCE);
		try{
			if (registry.resourceExists(resourcePath)) {
				Resource resource = registry.get(resourcePath);
				if (resource.getContent() != null) {
					if (resource.getContent() instanceof String) {
						propValue = (String) resource.getContent();
					} else if (resource.getContent() instanceof byte[]) {
						propValue = new String((byte[]) resource.getContent());
					}
				}
			} else {
				log.error("googleAPIKey property doesn't exists");
			}
		}catch(RegistryException e) {
			log.error("Unable to read the resource content of googleAPIKey.",e);
		}
		return propValue;
	}

}
