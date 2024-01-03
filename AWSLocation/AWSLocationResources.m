//
// Copyright 2010-2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSLocationResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSLocationResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSLocationResources

+ (instancetype)sharedInstance {
    static AWSLocationResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSLocationResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2020-11-19\",\
    \"endpointPrefix\":\"geo\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"rest-json\",\
    \"serviceFullName\":\"Amazon Location Service\",\
    \"serviceId\":\"Location\",\
    \"signatureVersion\":\"v4\",\
    \"signingName\":\"geo\",\
    \"uid\":\"location-2020-11-19\"\
  },\
  \"operations\":{\
    \"AssociateTrackerConsumer\":{\
      \"name\":\"AssociateTrackerConsumer\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/consumers\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"AssociateTrackerConsumerRequest\"},\
      \"output\":{\"shape\":\"AssociateTrackerConsumerResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates an association between a geofence collection and a tracker resource. This allows the tracker resource to communicate location data to the linked geofence collection. </p> <p>You can associate up to five geofence collections to each tracker resource.</p> <note> <p>Currently not supported â Cross-account configurations, such as creating associations between a tracker resource in one account and a geofence collection in another account.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"}\
    },\
    \"BatchDeleteDevicePositionHistory\":{\
      \"name\":\"BatchDeleteDevicePositionHistory\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/delete-positions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"BatchDeleteDevicePositionHistoryRequest\"},\
      \"output\":{\"shape\":\"BatchDeleteDevicePositionHistoryResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes the position history of one or more devices from a tracker resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"tracking.\"}\
    },\
    \"BatchDeleteGeofence\":{\
      \"name\":\"BatchDeleteGeofence\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}/delete-geofences\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"BatchDeleteGeofenceRequest\"},\
      \"output\":{\"shape\":\"BatchDeleteGeofenceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes a batch of geofences from a geofence collection.</p> <note> <p>This operation deletes the resource permanently.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"geofencing.\"}\
    },\
    \"BatchEvaluateGeofences\":{\
      \"name\":\"BatchEvaluateGeofences\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}/positions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"BatchEvaluateGeofencesRequest\"},\
      \"output\":{\"shape\":\"BatchEvaluateGeofencesResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Evaluates device positions against the geofence geometries from a given geofence collection.</p> <p>This operation always returns an empty response because geofences are asynchronously evaluated. The evaluation determines if the device has entered or exited a geofenced area, and then publishes one of the following events to Amazon EventBridge:</p> <ul> <li> <p> <code>ENTER</code> if Amazon Location determines that the tracked device has entered a geofenced area.</p> </li> <li> <p> <code>EXIT</code> if Amazon Location determines that the tracked device has exited a geofenced area.</p> </li> </ul> <note> <p>The last geofence that a device was observed within is tracked for 30 days after the most recent device position update.</p> </note> <note> <p>Geofence evaluation uses the given device position. It does not account for the optional <code>Accuracy</code> of a <code>DevicePositionUpdate</code>.</p> </note> <note> <p>The <code>DeviceID</code> is used as a string to represent the device. You do not need to have a <code>Tracker</code> associated with the <code>DeviceID</code>.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"geofencing.\"}\
    },\
    \"BatchGetDevicePosition\":{\
      \"name\":\"BatchGetDevicePosition\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/get-positions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"BatchGetDevicePositionRequest\"},\
      \"output\":{\"shape\":\"BatchGetDevicePositionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists the latest device positions for requested devices.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"tracking.\"}\
    },\
    \"BatchPutGeofence\":{\
      \"name\":\"BatchPutGeofence\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}/put-geofences\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"BatchPutGeofenceRequest\"},\
      \"output\":{\"shape\":\"BatchPutGeofenceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>A batch request for storing geofence geometries into a given geofence collection, or updates the geometry of an existing geofence if a geofence ID is included in the request.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"geofencing.\"}\
    },\
    \"BatchUpdateDevicePosition\":{\
      \"name\":\"BatchUpdateDevicePosition\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/positions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"BatchUpdateDevicePositionRequest\"},\
      \"output\":{\"shape\":\"BatchUpdateDevicePositionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Uploads position update data for one or more devices to a tracker resource (up to 10 devices per batch). Amazon Location uses the data when it reports the last known device position and position history. Amazon Location retains location data for 30 days.</p> <note> <p>Position updates are handled based on the <code>PositionFiltering</code> property of the tracker. When <code>PositionFiltering</code> is set to <code>TimeBased</code>, updates are evaluated against linked geofence collections, and location data is stored at a maximum of one position per 30 second interval. If your update frequency is more often than every 30 seconds, only one update per 30 seconds is stored for each unique device ID.</p> <p>When <code>PositionFiltering</code> is set to <code>DistanceBased</code> filtering, location data is stored and evaluated against linked geofence collections only if the device has moved more than 30 m (98.4 ft).</p> <p>When <code>PositionFiltering</code> is set to <code>AccuracyBased</code> filtering, location data is stored and evaluated against linked geofence collections only if the device has moved more than the measured accuracy. For example, if two consecutive updates from a device have a horizontal accuracy of 5 m and 10 m, the second update is neither stored or evaluated if the device has moved less than 15 m. If <code>PositionFiltering</code> is set to <code>AccuracyBased</code> filtering, Amazon Location uses the default value <code>{ \\\"Horizontal\\\": 0}</code> when accuracy is not provided on a <code>DevicePositionUpdate</code>.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"tracking.\"}\
    },\
    \"CalculateRoute\":{\
      \"name\":\"CalculateRoute\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/routes/v0/calculators/{CalculatorName}/calculate/route\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CalculateRouteRequest\"},\
      \"output\":{\"shape\":\"CalculateRouteResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p> <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/calculate-route.html\\\">Calculates a route</a> given the following required parameters: <code>DeparturePosition</code> and <code>DestinationPosition</code>. Requires that you first <a href=\\\"https://docs.aws.amazon.com/location-routes/latest/APIReference/API_CreateRouteCalculator.html\\\">create a route calculator resource</a>.</p> <p>By default, a request that doesn't specify a departure time uses the best time of day to travel with the best traffic conditions when calculating the route.</p> <p>Additional options include:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/departure-time.html\\\">Specifying a departure time</a> using either <code>DepartureTime</code> or <code>DepartNow</code>. This calculates a route based on predictive traffic data at the given time. </p> <note> <p>You can't specify both <code>DepartureTime</code> and <code>DepartNow</code> in a single request. Specifying both parameters returns a validation error.</p> </note> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/travel-mode.html\\\">Specifying a travel mode</a> using TravelMode sets the transportation mode used to calculate the routes. This also lets you specify additional route preferences in <code>CarModeOptions</code> if traveling by <code>Car</code>, or <code>TruckModeOptions</code> if traveling by <code>Truck</code>.</p> <note> <p>If you specify <code>walking</code> for the travel mode and your data provider is Esri, the start and destination must be within 40km.</p> </note> </li> </ul>\",\
      \"endpoint\":{\"hostPrefix\":\"routes.\"}\
    },\
    \"CalculateRouteMatrix\":{\
      \"name\":\"CalculateRouteMatrix\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/routes/v0/calculators/{CalculatorName}/calculate/route-matrix\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CalculateRouteMatrixRequest\"},\
      \"output\":{\"shape\":\"CalculateRouteMatrixResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p> <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/calculate-route-matrix.html\\\"> Calculates a route matrix</a> given the following required parameters: <code>DeparturePositions</code> and <code>DestinationPositions</code>. <code>CalculateRouteMatrix</code> calculates routes and returns the travel time and travel distance from each departure position to each destination position in the request. For example, given departure positions A and B, and destination positions X and Y, <code>CalculateRouteMatrix</code> will return time and distance for routes from A to X, A to Y, B to X, and B to Y (in that order). The number of results returned (and routes calculated) will be the number of <code>DeparturePositions</code> times the number of <code>DestinationPositions</code>.</p> <note> <p>Your account is charged for each route calculated, not the number of requests.</p> </note> <p>Requires that you first <a href=\\\"https://docs.aws.amazon.com/location-routes/latest/APIReference/API_CreateRouteCalculator.html\\\">create a route calculator resource</a>.</p> <p>By default, a request that doesn't specify a departure time uses the best time of day to travel with the best traffic conditions when calculating routes.</p> <p>Additional options include:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/departure-time.html\\\"> Specifying a departure time</a> using either <code>DepartureTime</code> or <code>DepartNow</code>. This calculates routes based on predictive traffic data at the given time. </p> <note> <p>You can't specify both <code>DepartureTime</code> and <code>DepartNow</code> in a single request. Specifying both parameters returns a validation error.</p> </note> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/travel-mode.html\\\">Specifying a travel mode</a> using TravelMode sets the transportation mode used to calculate the routes. This also lets you specify additional route preferences in <code>CarModeOptions</code> if traveling by <code>Car</code>, or <code>TruckModeOptions</code> if traveling by <code>Truck</code>.</p> </li> </ul>\",\
      \"endpoint\":{\"hostPrefix\":\"routes.\"}\
    },\
    \"CreateGeofenceCollection\":{\
      \"name\":\"CreateGeofenceCollection\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/geofencing/v0/collections\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CreateGeofenceCollectionRequest\"},\
      \"output\":{\"shape\":\"CreateGeofenceCollectionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates a geofence collection, which manages and stores geofences.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.geofencing.\"},\
      \"idempotent\":true\
    },\
    \"CreateKey\":{\
      \"name\":\"CreateKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/metadata/v0/keys\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CreateKeyRequest\"},\
      \"output\":{\"shape\":\"CreateKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates an API key resource in your Amazon Web Services account, which lets you grant actions for Amazon Location resources to the API key bearer.</p> <note> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">Using API keys</a>.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"},\
      \"idempotent\":true\
    },\
    \"CreateMap\":{\
      \"name\":\"CreateMap\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/maps/v0/maps\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CreateMapRequest\"},\
      \"output\":{\"shape\":\"CreateMapResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates a map resource in your Amazon Web Services account, which provides map tiles of different styles sourced from global location data providers.</p> <note> <p>If your application is tracking or routing assets you use in your business, such as delivery vehicles or employees, you must not use Esri as your geolocation provider. See section 82 of the <a href=\\\"http://aws.amazon.com/service-terms\\\">Amazon Web Services service terms</a> for more details.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.maps.\"},\
      \"idempotent\":true\
    },\
    \"CreatePlaceIndex\":{\
      \"name\":\"CreatePlaceIndex\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/places/v0/indexes\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CreatePlaceIndexRequest\"},\
      \"output\":{\"shape\":\"CreatePlaceIndexResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates a place index resource in your Amazon Web Services account. Use a place index resource to geocode addresses and other text queries by using the <code>SearchPlaceIndexForText</code> operation, and reverse geocode coordinates by using the <code>SearchPlaceIndexForPosition</code> operation, and enable autosuggestions by using the <code>SearchPlaceIndexForSuggestions</code> operation.</p> <note> <p>If your application is tracking or routing assets you use in your business, such as delivery vehicles or employees, you must not use Esri as your geolocation provider. See section 82 of the <a href=\\\"http://aws.amazon.com/service-terms\\\">Amazon Web Services service terms</a> for more details.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.places.\"},\
      \"idempotent\":true\
    },\
    \"CreateRouteCalculator\":{\
      \"name\":\"CreateRouteCalculator\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/routes/v0/calculators\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CreateRouteCalculatorRequest\"},\
      \"output\":{\"shape\":\"CreateRouteCalculatorResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates a route calculator resource in your Amazon Web Services account.</p> <p>You can send requests to a route calculator resource to estimate travel time, distance, and get directions. A route calculator sources traffic and road network data from your chosen data provider.</p> <note> <p>If your application is tracking or routing assets you use in your business, such as delivery vehicles or employees, you must not use Esri as your geolocation provider. See section 82 of the <a href=\\\"http://aws.amazon.com/service-terms\\\">Amazon Web Services service terms</a> for more details.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.routes.\"},\
      \"idempotent\":true\
    },\
    \"CreateTracker\":{\
      \"name\":\"CreateTracker\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"CreateTrackerRequest\"},\
      \"output\":{\"shape\":\"CreateTrackerResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ServiceQuotaExceededException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Creates a tracker resource in your Amazon Web Services account, which lets you retrieve current and historical location of devices.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"},\
      \"idempotent\":true\
    },\
    \"DeleteGeofenceCollection\":{\
      \"name\":\"DeleteGeofenceCollection\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DeleteGeofenceCollectionRequest\"},\
      \"output\":{\"shape\":\"DeleteGeofenceCollectionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes a geofence collection from your Amazon Web Services account.</p> <note> <p>This operation deletes the resource permanently. If the geofence collection is the target of a tracker resource, the devices will no longer be monitored.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.geofencing.\"},\
      \"idempotent\":true\
    },\
    \"DeleteKey\":{\
      \"name\":\"DeleteKey\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/metadata/v0/keys/{KeyName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DeleteKeyRequest\"},\
      \"output\":{\"shape\":\"DeleteKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified API key. The API key must have been deactivated more than 90 days previously.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"},\
      \"idempotent\":true\
    },\
    \"DeleteMap\":{\
      \"name\":\"DeleteMap\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DeleteMapRequest\"},\
      \"output\":{\"shape\":\"DeleteMapResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes a map resource from your Amazon Web Services account.</p> <note> <p>This operation deletes the resource permanently. If the map is being used in an application, the map may not render.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.maps.\"},\
      \"idempotent\":true\
    },\
    \"DeletePlaceIndex\":{\
      \"name\":\"DeletePlaceIndex\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DeletePlaceIndexRequest\"},\
      \"output\":{\"shape\":\"DeletePlaceIndexResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes a place index resource from your Amazon Web Services account.</p> <note> <p>This operation deletes the resource permanently.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.places.\"},\
      \"idempotent\":true\
    },\
    \"DeleteRouteCalculator\":{\
      \"name\":\"DeleteRouteCalculator\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/routes/v0/calculators/{CalculatorName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DeleteRouteCalculatorRequest\"},\
      \"output\":{\"shape\":\"DeleteRouteCalculatorResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes a route calculator resource from your Amazon Web Services account.</p> <note> <p>This operation deletes the resource permanently.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.routes.\"},\
      \"idempotent\":true\
    },\
    \"DeleteTracker\":{\
      \"name\":\"DeleteTracker\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DeleteTrackerRequest\"},\
      \"output\":{\"shape\":\"DeleteTrackerResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Deletes a tracker resource from your Amazon Web Services account.</p> <note> <p>This operation deletes the resource permanently. If the tracker resource is in use, you may encounter an error. Make sure that the target resource isn't a dependency for your applications.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"},\
      \"idempotent\":true\
    },\
    \"DescribeGeofenceCollection\":{\
      \"name\":\"DescribeGeofenceCollection\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DescribeGeofenceCollectionRequest\"},\
      \"output\":{\"shape\":\"DescribeGeofenceCollectionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the geofence collection details.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.geofencing.\"}\
    },\
    \"DescribeKey\":{\
      \"name\":\"DescribeKey\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/metadata/v0/keys/{KeyName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DescribeKeyRequest\"},\
      \"output\":{\"shape\":\"DescribeKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the API key resource details.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"}\
    },\
    \"DescribeMap\":{\
      \"name\":\"DescribeMap\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DescribeMapRequest\"},\
      \"output\":{\"shape\":\"DescribeMapResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the map resource details.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.maps.\"}\
    },\
    \"DescribePlaceIndex\":{\
      \"name\":\"DescribePlaceIndex\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DescribePlaceIndexRequest\"},\
      \"output\":{\"shape\":\"DescribePlaceIndexResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the place index resource details.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.places.\"}\
    },\
    \"DescribeRouteCalculator\":{\
      \"name\":\"DescribeRouteCalculator\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/routes/v0/calculators/{CalculatorName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DescribeRouteCalculatorRequest\"},\
      \"output\":{\"shape\":\"DescribeRouteCalculatorResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the route calculator resource details.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.routes.\"}\
    },\
    \"DescribeTracker\":{\
      \"name\":\"DescribeTracker\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DescribeTrackerRequest\"},\
      \"output\":{\"shape\":\"DescribeTrackerResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the tracker resource details.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"}\
    },\
    \"DisassociateTrackerConsumer\":{\
      \"name\":\"DisassociateTrackerConsumer\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/consumers/{ConsumerArn}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"DisassociateTrackerConsumerRequest\"},\
      \"output\":{\"shape\":\"DisassociateTrackerConsumerResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Removes the association between a tracker resource and a geofence collection.</p> <note> <p>Once you unlink a tracker resource from a geofence collection, the tracker positions will no longer be automatically evaluated against geofences.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"}\
    },\
    \"GetDevicePosition\":{\
      \"name\":\"GetDevicePosition\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/devices/{DeviceId}/positions/latest\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetDevicePositionRequest\"},\
      \"output\":{\"shape\":\"GetDevicePositionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves a device's most recent position according to its sample time.</p> <note> <p>Device positions are deleted after 30 days.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"tracking.\"}\
    },\
    \"GetDevicePositionHistory\":{\
      \"name\":\"GetDevicePositionHistory\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/devices/{DeviceId}/list-positions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetDevicePositionHistoryRequest\"},\
      \"output\":{\"shape\":\"GetDevicePositionHistoryResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the device position history from a tracker resource within a specified range of time.</p> <note> <p>Device positions are deleted after 30 days.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"tracking.\"}\
    },\
    \"GetGeofence\":{\
      \"name\":\"GetGeofence\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}/geofences/{GeofenceId}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetGeofenceRequest\"},\
      \"output\":{\"shape\":\"GetGeofenceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the geofence details from a geofence collection.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"geofencing.\"}\
    },\
    \"GetMapGlyphs\":{\
      \"name\":\"GetMapGlyphs\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}/glyphs/{FontStack}/{FontUnicodeRange}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetMapGlyphsRequest\"},\
      \"output\":{\"shape\":\"GetMapGlyphsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves glyphs used to display labels on a map.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"maps.\"}\
    },\
    \"GetMapSprites\":{\
      \"name\":\"GetMapSprites\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}/sprites/{FileName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetMapSpritesRequest\"},\
      \"output\":{\"shape\":\"GetMapSpritesResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the sprite sheet corresponding to a map resource. The sprite sheet is a PNG image paired with a JSON document describing the offsets of individual icons that will be displayed on a rendered map.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"maps.\"}\
    },\
    \"GetMapStyleDescriptor\":{\
      \"name\":\"GetMapStyleDescriptor\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}/style-descriptor\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetMapStyleDescriptorRequest\"},\
      \"output\":{\"shape\":\"GetMapStyleDescriptorResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves the map style descriptor from a map resource. </p> <p>The style descriptor contains speciï¬cations on how features render on a map. For example, what data to display, what order to display the data in, and the style for the data. Style descriptors follow the Mapbox Style Specification.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"maps.\"}\
    },\
    \"GetMapTile\":{\
      \"name\":\"GetMapTile\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}/tiles/{Z}/{X}/{Y}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetMapTileRequest\"},\
      \"output\":{\"shape\":\"GetMapTileResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Retrieves a vector data tile from the map resource. Map tiles are used by clients to render a map. they're addressed using a grid arrangement with an X coordinate, Y coordinate, and Z (zoom) level. </p> <p>The origin (0, 0) is the top left of the map. Increasing the zoom level by 1 doubles both the X and Y dimensions, so a tile containing data for the entire world at (0/0/0) will be split into 4 tiles at zoom 1 (1/0/0, 1/0/1, 1/1/0, 1/1/1).</p>\",\
      \"endpoint\":{\"hostPrefix\":\"maps.\"}\
    },\
    \"GetPlace\":{\
      \"name\":\"GetPlace\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}/places/{PlaceId}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"GetPlaceRequest\"},\
      \"output\":{\"shape\":\"GetPlaceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Finds a place by its unique ID. A <code>PlaceId</code> is returned by other search operations.</p> <note> <p>A PlaceId is valid only if all of the following are the same in the original search request and the call to <code>GetPlace</code>.</p> <ul> <li> <p>Customer Amazon Web Services account</p> </li> <li> <p>Amazon Web Services Region</p> </li> <li> <p>Data provider specified in the place index resource</p> </li> </ul> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"places.\"}\
    },\
    \"ListDevicePositions\":{\
      \"name\":\"ListDevicePositions\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/list-positions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListDevicePositionsRequest\"},\
      \"output\":{\"shape\":\"ListDevicePositionsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>A batch request to retrieve all device positions.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"tracking.\"}\
    },\
    \"ListGeofenceCollections\":{\
      \"name\":\"ListGeofenceCollections\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/geofencing/v0/list-collections\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListGeofenceCollectionsRequest\"},\
      \"output\":{\"shape\":\"ListGeofenceCollectionsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists geofence collections in your Amazon Web Services account.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.geofencing.\"}\
    },\
    \"ListGeofences\":{\
      \"name\":\"ListGeofences\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}/list-geofences\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListGeofencesRequest\"},\
      \"output\":{\"shape\":\"ListGeofencesResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists geofences stored in a given geofence collection.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"geofencing.\"}\
    },\
    \"ListKeys\":{\
      \"name\":\"ListKeys\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/metadata/v0/list-keys\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListKeysRequest\"},\
      \"output\":{\"shape\":\"ListKeysResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists API key resources in your Amazon Web Services account.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"}\
    },\
    \"ListMaps\":{\
      \"name\":\"ListMaps\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/maps/v0/list-maps\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListMapsRequest\"},\
      \"output\":{\"shape\":\"ListMapsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists map resources in your Amazon Web Services account.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.maps.\"}\
    },\
    \"ListPlaceIndexes\":{\
      \"name\":\"ListPlaceIndexes\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/places/v0/list-indexes\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListPlaceIndexesRequest\"},\
      \"output\":{\"shape\":\"ListPlaceIndexesResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists place index resources in your Amazon Web Services account.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.places.\"}\
    },\
    \"ListRouteCalculators\":{\
      \"name\":\"ListRouteCalculators\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/routes/v0/list-calculators\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListRouteCalculatorsRequest\"},\
      \"output\":{\"shape\":\"ListRouteCalculatorsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists route calculator resources in your Amazon Web Services account.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.routes.\"}\
    },\
    \"ListTagsForResource\":{\
      \"name\":\"ListTagsForResource\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/tags/{ResourceArn}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListTagsForResourceRequest\"},\
      \"output\":{\"shape\":\"ListTagsForResourceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of tags that are applied to the specified Amazon Location resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"}\
    },\
    \"ListTrackerConsumers\":{\
      \"name\":\"ListTrackerConsumers\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}/list-consumers\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListTrackerConsumersRequest\"},\
      \"output\":{\"shape\":\"ListTrackerConsumersResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists geofence collections currently associated to the given tracker resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"}\
    },\
    \"ListTrackers\":{\
      \"name\":\"ListTrackers\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tracking/v0/list-trackers\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"ListTrackersRequest\"},\
      \"output\":{\"shape\":\"ListTrackersResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Lists tracker resources in your Amazon Web Services account.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"}\
    },\
    \"PutGeofence\":{\
      \"name\":\"PutGeofence\",\
      \"http\":{\
        \"method\":\"PUT\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}/geofences/{GeofenceId}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"PutGeofenceRequest\"},\
      \"output\":{\"shape\":\"PutGeofenceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Stores a geofence geometry in a given geofence collection, or updates the geometry of an existing geofence if a geofence ID is included in the request. </p>\",\
      \"endpoint\":{\"hostPrefix\":\"geofencing.\"}\
    },\
    \"SearchPlaceIndexForPosition\":{\
      \"name\":\"SearchPlaceIndexForPosition\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}/search/position\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"SearchPlaceIndexForPositionRequest\"},\
      \"output\":{\"shape\":\"SearchPlaceIndexForPositionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Reverse geocodes a given coordinate and returns a legible address. Allows you to search for Places or points of interest near a given position.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"places.\"}\
    },\
    \"SearchPlaceIndexForSuggestions\":{\
      \"name\":\"SearchPlaceIndexForSuggestions\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}/search/suggestions\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"SearchPlaceIndexForSuggestionsRequest\"},\
      \"output\":{\"shape\":\"SearchPlaceIndexForSuggestionsResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Generates suggestions for addresses and points of interest based on partial or misspelled free-form text. This operation is also known as autocomplete, autosuggest, or fuzzy matching.</p> <p>Optional parameters let you narrow your search results by bounding box or country, or bias your search toward a specific position on the globe.</p> <note> <p>You can search for suggested place names near a specified position by using <code>BiasPosition</code>, or filter results within a bounding box by using <code>FilterBBox</code>. These parameters are mutually exclusive; using both <code>BiasPosition</code> and <code>FilterBBox</code> in the same command returns an error.</p> </note>\",\
      \"endpoint\":{\"hostPrefix\":\"places.\"}\
    },\
    \"SearchPlaceIndexForText\":{\
      \"name\":\"SearchPlaceIndexForText\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}/search/text\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"SearchPlaceIndexForTextRequest\"},\
      \"output\":{\"shape\":\"SearchPlaceIndexForTextResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Geocodes free-form text, such as an address, name, city, or region to allow you to search for Places or points of interest. </p> <p>Optional parameters let you narrow your search results by bounding box or country, or bias your search toward a specific position on the globe.</p> <note> <p>You can search for places near a given position using <code>BiasPosition</code>, or filter results within a bounding box using <code>FilterBBox</code>. Providing both parameters simultaneously returns an error.</p> </note> <p>Search results are returned in order of highest to lowest relevance.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"places.\"}\
    },\
    \"TagResource\":{\
      \"name\":\"TagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/tags/{ResourceArn}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"TagResourceRequest\"},\
      \"output\":{\"shape\":\"TagResourceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Assigns one or more tags (key-value pairs) to the specified Amazon Location Service resource.</p> <p>Tags can help you organize and categorize your resources. You can also use them to scope user permissions, by granting a user permission to access or change only resources with certain tag values.</p> <p>You can use the <code>TagResource</code> operation with an Amazon Location Service resource that already has tags. If you specify a new tag key for the resource, this tag is appended to the tags already associated with the resource. If you specify a tag key that's already associated with the resource, the new tag value that you specify replaces the previous value for that tag. </p> <p>You can associate up to 50 tags with a resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"}\
    },\
    \"UntagResource\":{\
      \"name\":\"UntagResource\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/tags/{ResourceArn}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UntagResourceRequest\"},\
      \"output\":{\"shape\":\"UntagResourceResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Removes one or more tags from the specified Amazon Location resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"},\
      \"idempotent\":true\
    },\
    \"UpdateGeofenceCollection\":{\
      \"name\":\"UpdateGeofenceCollection\",\
      \"http\":{\
        \"method\":\"PATCH\",\
        \"requestUri\":\"/geofencing/v0/collections/{CollectionName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UpdateGeofenceCollectionRequest\"},\
      \"output\":{\"shape\":\"UpdateGeofenceCollectionResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified properties of a given geofence collection.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.geofencing.\"},\
      \"idempotent\":true\
    },\
    \"UpdateKey\":{\
      \"name\":\"UpdateKey\",\
      \"http\":{\
        \"method\":\"PATCH\",\
        \"requestUri\":\"/metadata/v0/keys/{KeyName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UpdateKeyRequest\"},\
      \"output\":{\"shape\":\"UpdateKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified properties of a given API key resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.metadata.\"},\
      \"idempotent\":true\
    },\
    \"UpdateMap\":{\
      \"name\":\"UpdateMap\",\
      \"http\":{\
        \"method\":\"PATCH\",\
        \"requestUri\":\"/maps/v0/maps/{MapName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UpdateMapRequest\"},\
      \"output\":{\"shape\":\"UpdateMapResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified properties of a given map resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.maps.\"},\
      \"idempotent\":true\
    },\
    \"UpdatePlaceIndex\":{\
      \"name\":\"UpdatePlaceIndex\",\
      \"http\":{\
        \"method\":\"PATCH\",\
        \"requestUri\":\"/places/v0/indexes/{IndexName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UpdatePlaceIndexRequest\"},\
      \"output\":{\"shape\":\"UpdatePlaceIndexResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified properties of a given place index resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.places.\"},\
      \"idempotent\":true\
    },\
    \"UpdateRouteCalculator\":{\
      \"name\":\"UpdateRouteCalculator\",\
      \"http\":{\
        \"method\":\"PATCH\",\
        \"requestUri\":\"/routes/v0/calculators/{CalculatorName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UpdateRouteCalculatorRequest\"},\
      \"output\":{\"shape\":\"UpdateRouteCalculatorResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified properties for a given route calculator resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.routes.\"},\
      \"idempotent\":true\
    },\
    \"UpdateTracker\":{\
      \"name\":\"UpdateTracker\",\
      \"http\":{\
        \"method\":\"PATCH\",\
        \"requestUri\":\"/tracking/v0/trackers/{TrackerName}\",\
        \"responseCode\":200\
      },\
      \"input\":{\"shape\":\"UpdateTrackerRequest\"},\
      \"output\":{\"shape\":\"UpdateTrackerResponse\"},\
      \"errors\":[\
        {\"shape\":\"InternalServerException\"},\
        {\"shape\":\"ResourceNotFoundException\"},\
        {\"shape\":\"AccessDeniedException\"},\
        {\"shape\":\"ValidationException\"},\
        {\"shape\":\"ThrottlingException\"}\
      ],\
      \"documentation\":\"<p>Updates the specified properties of a given tracker resource.</p>\",\
      \"endpoint\":{\"hostPrefix\":\"cp.tracking.\"},\
      \"idempotent\":true\
    }\
  },\
  \"shapes\":{\
    \"AccessDeniedException\":{\
      \"type\":\"structure\",\
      \"required\":[\"Message\"],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"locationName\":\"message\"\
        }\
      },\
      \"documentation\":\"<p>The request was denied because of insufficient access or permissions. Check with an administrator to verify your permissions.</p>\",\
      \"error\":{\
        \"httpStatusCode\":403,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"ApiKey\":{\
      \"type\":\"string\",\
      \"max\":1000,\
      \"min\":0,\
      \"sensitive\":true\
    },\
    \"ApiKeyAction\":{\
      \"type\":\"string\",\
      \"max\":200,\
      \"min\":5,\
      \"pattern\":\"^geo:\\\\w*\\\\*?$\"\
    },\
    \"ApiKeyFilter\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyStatus\":{\
          \"shape\":\"Status\",\
          \"documentation\":\"<p>Filter on <code>Active</code> or <code>Expired</code> API keys.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Options for filtering API keys.</p>\"\
    },\
    \"ApiKeyRestrictions\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AllowActions\",\
        \"AllowResources\"\
      ],\
      \"members\":{\
        \"AllowActions\":{\
          \"shape\":\"ApiKeyRestrictionsAllowActionsList\",\
          \"documentation\":\"<p>A list of allowed actions that an API key resource grants permissions to perform. You must have at least one action for each type of resource. For example, if you have a place resource, you must include at least one place action.</p> <p>The following are valid values for the actions.</p> <ul> <li> <p> <b>Map actions</b> </p> <ul> <li> <p> <code>geo:GetMap*</code> - Allows all actions needed for map rendering.</p> </li> </ul> </li> <li> <p> <b>Place actions</b> </p> <ul> <li> <p> <code>geo:SearchPlaceIndexForText</code> - Allows geocoding.</p> </li> <li> <p> <code>geo:SearchPlaceIndexForPosition</code> - Allows reverse geocoding.</p> </li> <li> <p> <code>geo:SearchPlaceIndexForSuggestions</code> - Allows generating suggestions from text.</p> </li> <li> <p> <code>GetPlace</code> - Allows finding a place by place ID.</p> </li> </ul> </li> <li> <p> <b>Route actions</b> </p> <ul> <li> <p> <code>geo:CalculateRoute</code> - Allows point to point routing.</p> </li> <li> <p> <code>geo:CalculateRouteMatrix</code> - Allows calculating a matrix of routes.</p> </li> </ul> </li> </ul> <note> <p>You must use these strings exactly. For example, to provide access to map rendering, the only valid action is <code>geo:GetMap*</code> as an input to the list. <code>[\\\"geo:GetMap*\\\"]</code> is valid but <code>[\\\"geo:GetMapTile\\\"]</code> is not. Similarly, you cannot use <code>[\\\"geo:SearchPlaceIndexFor*\\\"]</code> - you must list each of the Place actions separately.</p> </note>\"\
        },\
        \"AllowReferers\":{\
          \"shape\":\"ApiKeyRestrictionsAllowReferersList\",\
          \"documentation\":\"<p>An optional list of allowed HTTP referers for which requests must originate from. Requests using this API key from other domains will not be allowed.</p> <p>Requirements:</p> <ul> <li> <p>Contain only alphanumeric characters (AâZ, aâz, 0â9) or any symbols in this list <code>$\\\\-._+!*`(),;/?:@=&amp;</code> </p> </li> <li> <p>May contain a percent (%) if followed by 2 hexadecimal digits (A-F, a-f, 0-9); this is used for URL encoding purposes.</p> </li> <li> <p>May contain wildcard characters question mark (?) and asterisk (*).</p> <p>Question mark (?) will replace any single character (including hexadecimal digits).</p> <p>Asterisk (*) will replace any multiple characters (including multiple hexadecimal digits).</p> </li> <li> <p>No spaces allowed. For example, <code>https://example.com</code>.</p> </li> </ul>\"\
        },\
        \"AllowResources\":{\
          \"shape\":\"ApiKeyRestrictionsAllowResourcesList\",\
          \"documentation\":\"<p>A list of allowed resource ARNs that a API key bearer can perform actions on.</p> <ul> <li> <p>The ARN must be the correct ARN for a map, place, or route ARN. You may include wildcards in the resource-id to match multiple resources of the same type.</p> </li> <li> <p>The resources must be in the same <code>partition</code>, <code>region</code>, and <code>account-id</code> as the key that is being created.</p> </li> <li> <p>Other than wildcards, you must include the full ARN, including the <code>arn</code>, <code>partition</code>, <code>service</code>, <code>region</code>, <code>account-id</code> and <code>resource-id</code> delimited by colons (:).</p> </li> <li> <p>No spaces allowed, even with wildcards. For example, <code>arn:aws:geo:region:<i>account-id</i>:map/ExampleMap*</code>.</p> </li> </ul> <p>For more information about ARN format, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Names (ARNs)</a>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>API Restrictions on the allowed actions, resources, and referers for an API key resource.</p>\"\
    },\
    \"ApiKeyRestrictionsAllowActionsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ApiKeyAction\"},\
      \"max\":7,\
      \"min\":1\
    },\
    \"ApiKeyRestrictionsAllowReferersList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"RefererPattern\"},\
      \"max\":5,\
      \"min\":1\
    },\
    \"ApiKeyRestrictionsAllowResourcesList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GeoArn\"},\
      \"max\":5,\
      \"min\":1\
    },\
    \"Arn\":{\
      \"type\":\"string\",\
      \"max\":1600,\
      \"min\":0,\
      \"pattern\":\"^arn(:[a-z0-9]+([.-][a-z0-9]+)*){2}(:([a-z0-9]+([.-][a-z0-9]+)*)?){2}:([^/].*)?$\"\
    },\
    \"ArnList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Arn\"}\
    },\
    \"AssociateTrackerConsumerRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ConsumerArn\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"ConsumerArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the geofence collection to be associated to tracker resource. Used when you need to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollectionConsumer</code> </p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource to be associated with a geofence collection.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"AssociateTrackerConsumerResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"BatchDeleteDevicePositionHistoryError\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"Error\"\
      ],\
      \"members\":{\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The ID of the device for this position.</p>\"\
        },\
        \"Error\":{\"shape\":\"BatchItemError\"}\
      },\
      \"documentation\":\"<p>Contains the tracker resource details.</p>\"\
    },\
    \"BatchDeleteDevicePositionHistoryErrorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchDeleteDevicePositionHistoryError\"}\
    },\
    \"BatchDeleteDevicePositionHistoryRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceIds\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"DeviceIds\":{\
          \"shape\":\"BatchDeleteDevicePositionHistoryRequestDeviceIdsList\",\
          \"documentation\":\"<p>Devices whose position history you want to delete.</p> <ul> <li> <p>For example, for two devices: <code>âDeviceIdsâ : [DeviceId1,DeviceId2]</code> </p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource to delete the device position history from.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"BatchDeleteDevicePositionHistoryRequestDeviceIdsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Id\"},\
      \"max\":100,\
      \"min\":1\
    },\
    \"BatchDeleteDevicePositionHistoryResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Errors\"],\
      \"members\":{\
        \"Errors\":{\
          \"shape\":\"BatchDeleteDevicePositionHistoryErrorList\",\
          \"documentation\":\"<p>Contains error details for each device history that failed to delete.</p>\"\
        }\
      }\
    },\
    \"BatchDeleteGeofenceError\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Error\",\
        \"GeofenceId\"\
      ],\
      \"members\":{\
        \"Error\":{\
          \"shape\":\"BatchItemError\",\
          \"documentation\":\"<p>Contains details associated to the batch error.</p>\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence associated with the error message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains error details for each geofence that failed to delete from the geofence collection.</p>\"\
    },\
    \"BatchDeleteGeofenceErrorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchDeleteGeofenceError\"}\
    },\
    \"BatchDeleteGeofenceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionName\",\
        \"GeofenceIds\"\
      ],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The geofence collection storing the geofences to be deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"GeofenceIds\":{\
          \"shape\":\"BatchDeleteGeofenceRequestGeofenceIdsList\",\
          \"documentation\":\"<p>The batch of geofences to be deleted.</p>\"\
        }\
      }\
    },\
    \"BatchDeleteGeofenceRequestGeofenceIdsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Id\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"BatchDeleteGeofenceResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Errors\"],\
      \"members\":{\
        \"Errors\":{\
          \"shape\":\"BatchDeleteGeofenceErrorList\",\
          \"documentation\":\"<p>Contains error details for each geofence that failed to delete.</p>\"\
        }\
      }\
    },\
    \"BatchEvaluateGeofencesError\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"Error\",\
        \"SampleTime\"\
      ],\
      \"members\":{\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device associated with the position evaluation error.</p>\"\
        },\
        \"Error\":{\
          \"shape\":\"BatchItemError\",\
          \"documentation\":\"<p>Contains details associated to the batch error.</p>\"\
        },\
        \"SampleTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specifies a timestamp for when the error occurred in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains error details for each device that failed to evaluate its position against the geofences in a given geofence collection.</p>\"\
    },\
    \"BatchEvaluateGeofencesErrorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchEvaluateGeofencesError\"}\
    },\
    \"BatchEvaluateGeofencesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionName\",\
        \"DevicePositionUpdates\"\
      ],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The geofence collection used in evaluating the position of devices against its geofences.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"DevicePositionUpdates\":{\
          \"shape\":\"BatchEvaluateGeofencesRequestDevicePositionUpdatesList\",\
          \"documentation\":\"<p>Contains device details for each device to be evaluated against the given geofence collection.</p>\"\
        }\
      }\
    },\
    \"BatchEvaluateGeofencesRequestDevicePositionUpdatesList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DevicePositionUpdate\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"BatchEvaluateGeofencesResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Errors\"],\
      \"members\":{\
        \"Errors\":{\
          \"shape\":\"BatchEvaluateGeofencesErrorList\",\
          \"documentation\":\"<p>Contains error details for each device that failed to evaluate its position against the given geofence collection.</p>\"\
        }\
      }\
    },\
    \"BatchGetDevicePositionError\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"Error\"\
      ],\
      \"members\":{\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The ID of the device that didn't return a position.</p>\"\
        },\
        \"Error\":{\
          \"shape\":\"BatchItemError\",\
          \"documentation\":\"<p>Contains details related to the error code.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains error details for each device that didn't return a position.</p>\"\
    },\
    \"BatchGetDevicePositionErrorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchGetDevicePositionError\"}\
    },\
    \"BatchGetDevicePositionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceIds\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"DeviceIds\":{\
          \"shape\":\"BatchGetDevicePositionRequestDeviceIdsList\",\
          \"documentation\":\"<p>Devices whose position you want to retrieve.</p> <ul> <li> <p>For example, for two devices: <code>device-ids=DeviceId1&amp;device-ids=DeviceId2</code> </p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"BatchGetDevicePositionRequestTrackerNameString\",\
          \"documentation\":\"<p>The tracker resource retrieving the device position.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"BatchGetDevicePositionRequestDeviceIdsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Id\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"BatchGetDevicePositionRequestTrackerNameString\":{\
      \"type\":\"string\",\
      \"min\":1,\
      \"pattern\":\"^[-._\\\\w]+$\"\
    },\
    \"BatchGetDevicePositionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DevicePositions\",\
        \"Errors\"\
      ],\
      \"members\":{\
        \"DevicePositions\":{\
          \"shape\":\"DevicePositionList\",\
          \"documentation\":\"<p>Contains device position details such as the device ID, position, and timestamps for when the position was received and sampled.</p>\"\
        },\
        \"Errors\":{\
          \"shape\":\"BatchGetDevicePositionErrorList\",\
          \"documentation\":\"<p>Contains error details for each device that failed to send its position to the tracker resource.</p>\"\
        }\
      }\
    },\
    \"BatchItemError\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Code\":{\
          \"shape\":\"BatchItemErrorCode\",\
          \"documentation\":\"<p>The error code associated with the batch request error.</p>\"\
        },\
        \"Message\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A message with the reason for the batch request error.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the batch request error details associated with the request.</p>\"\
    },\
    \"BatchItemErrorCode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AccessDeniedError\",\
        \"ConflictError\",\
        \"InternalServerError\",\
        \"ResourceNotFoundError\",\
        \"ThrottlingError\",\
        \"ValidationError\"\
      ]\
    },\
    \"BatchPutGeofenceError\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Error\",\
        \"GeofenceId\"\
      ],\
      \"members\":{\
        \"Error\":{\
          \"shape\":\"BatchItemError\",\
          \"documentation\":\"<p>Contains details associated to the batch error.</p>\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence associated with the error message.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains error details for each geofence that failed to be stored in a given geofence collection.</p>\"\
    },\
    \"BatchPutGeofenceErrorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchPutGeofenceError\"}\
    },\
    \"BatchPutGeofenceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionName\",\
        \"Entries\"\
      ],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The geofence collection storing the geofences.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"Entries\":{\
          \"shape\":\"BatchPutGeofenceRequestEntriesList\",\
          \"documentation\":\"<p>The batch of geofences to be stored in a geofence collection.</p>\"\
        }\
      }\
    },\
    \"BatchPutGeofenceRequestEntriesList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchPutGeofenceRequestEntry\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"BatchPutGeofenceRequestEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"GeofenceId\",\
        \"Geometry\"\
      ],\
      \"members\":{\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The identifier for the geofence to be stored in a given geofence collection.</p>\"\
        },\
        \"GeofenceProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>Associates one of more properties with the geofence. A property is a key-value pair stored with the geofence and added to any geofence event triggered with that geofence.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p>\"\
        },\
        \"Geometry\":{\
          \"shape\":\"GeofenceGeometry\",\
          \"documentation\":\"<p>Contains the details of the position of the geofence. Can be either a polygon or a circle. Including both will return a validation error.</p> <note> <p>Each <a href=\\\"https://docs.aws.amazon.com/location-geofences/latest/APIReference/API_GeofenceGeometry.html\\\"> geofence polygon</a> can have a maximum of 1,000 vertices.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Contains geofence geometry details. </p>\"\
    },\
    \"BatchPutGeofenceResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Errors\",\
        \"Successes\"\
      ],\
      \"members\":{\
        \"Errors\":{\
          \"shape\":\"BatchPutGeofenceErrorList\",\
          \"documentation\":\"<p>Contains additional error details for each geofence that failed to be stored in a geofence collection.</p>\"\
        },\
        \"Successes\":{\
          \"shape\":\"BatchPutGeofenceSuccessList\",\
          \"documentation\":\"<p>Contains each geofence that was successfully stored in a geofence collection.</p>\"\
        }\
      }\
    },\
    \"BatchPutGeofenceSuccess\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"GeofenceId\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence was stored in a geofence collection in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence successfully stored in a geofence collection.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains a summary of each geofence that was successfully stored in a given geofence collection.</p>\"\
    },\
    \"BatchPutGeofenceSuccessList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchPutGeofenceSuccess\"}\
    },\
    \"BatchUpdateDevicePositionError\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"Error\",\
        \"SampleTime\"\
      ],\
      \"members\":{\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device associated with the failed location update.</p>\"\
        },\
        \"Error\":{\
          \"shape\":\"BatchItemError\",\
          \"documentation\":\"<p>Contains details related to the error code such as the error code and error message.</p>\"\
        },\
        \"SampleTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp at which the device position was determined. Uses <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains error details for each device that failed to update its position.</p>\"\
    },\
    \"BatchUpdateDevicePositionErrorList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"BatchUpdateDevicePositionError\"}\
    },\
    \"BatchUpdateDevicePositionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TrackerName\",\
        \"Updates\"\
      ],\
      \"members\":{\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        },\
        \"Updates\":{\
          \"shape\":\"BatchUpdateDevicePositionRequestUpdatesList\",\
          \"documentation\":\"<p>Contains the position update details for each device, up to 10 devices.</p>\"\
        }\
      }\
    },\
    \"BatchUpdateDevicePositionRequestUpdatesList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DevicePositionUpdate\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"BatchUpdateDevicePositionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Errors\"],\
      \"members\":{\
        \"Errors\":{\
          \"shape\":\"BatchUpdateDevicePositionErrorList\",\
          \"documentation\":\"<p>Contains error details for each device that failed to update its position.</p>\"\
        }\
      }\
    },\
    \"Blob\":{\"type\":\"blob\"},\
    \"Boolean\":{\
      \"type\":\"boolean\",\
      \"box\":true\
    },\
    \"BoundingBox\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Double\"},\
      \"max\":4,\
      \"min\":4,\
      \"sensitive\":true\
    },\
    \"CalculateRouteCarModeOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AvoidFerries\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Avoids ferries when calculating routes.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        },\
        \"AvoidTolls\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Avoids tolls when calculating routes.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details about additional route preferences for requests that specify <code>TravelMode</code> as <code>Car</code>.</p>\"\
    },\
    \"CalculateRouteMatrixRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorName\",\
        \"DeparturePositions\",\
        \"DestinationPositions\"\
      ],\
      \"members\":{\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource that you want to use to calculate the route matrix. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CalculatorName\"\
        },\
        \"CarModeOptions\":{\
          \"shape\":\"CalculateRouteCarModeOptions\",\
          \"documentation\":\"<p>Specifies route preferences when traveling by <code>Car</code>, such as avoiding routes that use ferries or tolls.</p> <p>Requirements: <code>TravelMode</code> must be specified as <code>Car</code>.</p>\"\
        },\
        \"DepartNow\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Sets the time of departure as the current time. Uses the current time to calculate the route matrix. You can't set both <code>DepartureTime</code> and <code>DepartNow</code>. If neither is set, the best time of day to travel with the best traffic conditions is used to calculate the route matrix.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        },\
        \"DeparturePositions\":{\
          \"shape\":\"CalculateRouteMatrixRequestDeparturePositionsList\",\
          \"documentation\":\"<p>The list of departure (origin) positions for the route matrix. An array of points, each of which is itself a 2-value array defined in <a href=\\\"https://earth-info.nga.mil/GandG/wgs84/index.html\\\">WGS 84</a> format: <code>[longitude, latitude]</code>. For example, <code>[-123.115, 49.285]</code>.</p> <important> <p>Depending on the data provider selected in the route calculator resource there may be additional restrictions on the inputs you can choose. See <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/calculate-route-matrix.html#matrix-routing-position-limits\\\"> Position restrictions</a> in the <i>Amazon Location Service Developer Guide</i>.</p> </important> <note> <p>For route calculators that use Esri as the data provider, if you specify a departure that's not located on a road, Amazon Location <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\"> moves the position to the nearest road</a>. The snapped value is available in the result in <code>SnappedDeparturePositions</code>.</p> </note> <p>Valid Values: <code>[-180 to 180,-90 to 90]</code> </p>\"\
        },\
        \"DepartureTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specifies the desired time of departure. Uses the given time to calculate the route matrix. You can't set both <code>DepartureTime</code> and <code>DepartNow</code>. If neither is set, the best time of day to travel with the best traffic conditions is used to calculate the route matrix.</p> <note> <p>Setting a departure time in the past returns a <code>400 ValidationException</code> error.</p> </note> <ul> <li> <p>In <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        },\
        \"DestinationPositions\":{\
          \"shape\":\"CalculateRouteMatrixRequestDestinationPositionsList\",\
          \"documentation\":\"<p>The list of destination positions for the route matrix. An array of points, each of which is itself a 2-value array defined in <a href=\\\"https://earth-info.nga.mil/GandG/wgs84/index.html\\\">WGS 84</a> format: <code>[longitude, latitude]</code>. For example, <code>[-122.339, 47.615]</code> </p> <important> <p>Depending on the data provider selected in the route calculator resource there may be additional restrictions on the inputs you can choose. See <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/calculate-route-matrix.html#matrix-routing-position-limits\\\"> Position restrictions</a> in the <i>Amazon Location Service Developer Guide</i>.</p> </important> <note> <p>For route calculators that use Esri as the data provider, if you specify a destination that's not located on a road, Amazon Location <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\"> moves the position to the nearest road</a>. The snapped value is available in the result in <code>SnappedDestinationPositions</code>.</p> </note> <p>Valid Values: <code>[-180 to 180,-90 to 90]</code> </p>\"\
        },\
        \"DistanceUnit\":{\
          \"shape\":\"DistanceUnit\",\
          \"documentation\":\"<p>Set the unit system to specify the distance.</p> <p>Default Value: <code>Kilometers</code> </p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"TravelMode\":{\
          \"shape\":\"TravelMode\",\
          \"documentation\":\"<p>Specifies the mode of transport when calculating a route. Used in estimating the speed of travel and road compatibility.</p> <p>The <code>TravelMode</code> you specify also determines how you specify route preferences: </p> <ul> <li> <p>If traveling by <code>Car</code> use the <code>CarModeOptions</code> parameter.</p> </li> <li> <p>If traveling by <code>Truck</code> use the <code>TruckModeOptions</code> parameter.</p> </li> </ul> <note> <p> <code>Bicycle</code> or <code>Motorcycle</code> are only valid when using <code>Grab</code> as a data provider, and only within Southeast Asia.</p> <p> <code>Truck</code> is not available for Grab.</p> <p>For more information about using Grab as a data provider, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html\\\">GrabMaps</a> in the <i>Amazon Location Service Developer Guide</i>.</p> </note> <p>Default Value: <code>Car</code> </p>\"\
        },\
        \"TruckModeOptions\":{\
          \"shape\":\"CalculateRouteTruckModeOptions\",\
          \"documentation\":\"<p>Specifies route preferences when traveling by <code>Truck</code>, such as avoiding routes that use ferries or tolls, and truck specifications to consider when choosing an optimal road.</p> <p>Requirements: <code>TravelMode</code> must be specified as <code>Truck</code>.</p>\"\
        }\
      }\
    },\
    \"CalculateRouteMatrixRequestDeparturePositionsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"max\":350,\
      \"min\":1\
    },\
    \"CalculateRouteMatrixRequestDestinationPositionsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"max\":350,\
      \"min\":1\
    },\
    \"CalculateRouteMatrixResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"RouteMatrix\",\
        \"Summary\"\
      ],\
      \"members\":{\
        \"RouteMatrix\":{\
          \"shape\":\"RouteMatrix\",\
          \"documentation\":\"<p>The calculated route matrix containing the results for all pairs of <code>DeparturePositions</code> to <code>DestinationPositions</code>. Each row corresponds to one entry in <code>DeparturePositions</code>. Each entry in the row corresponds to the route from that entry in <code>DeparturePositions</code> to an entry in <code>DestinationPositions</code>. </p>\"\
        },\
        \"SnappedDeparturePositions\":{\
          \"shape\":\"CalculateRouteMatrixResponseSnappedDeparturePositionsList\",\
          \"documentation\":\"<p>For routes calculated using an Esri route calculator resource, departure positions are snapped to the closest road. For Esri route calculator resources, this returns the list of departure/origin positions used for calculation of the <code>RouteMatrix</code>.</p>\"\
        },\
        \"SnappedDestinationPositions\":{\
          \"shape\":\"CalculateRouteMatrixResponseSnappedDestinationPositionsList\",\
          \"documentation\":\"<p>The list of destination positions for the route matrix used for calculation of the <code>RouteMatrix</code>.</p>\"\
        },\
        \"Summary\":{\
          \"shape\":\"CalculateRouteMatrixSummary\",\
          \"documentation\":\"<p>Contains information about the route matrix, <code>DataSource</code>, <code>DistanceUnit</code>, <code>RouteCount</code> and <code>ErrorCount</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Returns the result of the route matrix calculation.</p>\"\
    },\
    \"CalculateRouteMatrixResponseSnappedDeparturePositionsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"max\":350,\
      \"min\":1\
    },\
    \"CalculateRouteMatrixResponseSnappedDestinationPositionsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"max\":350,\
      \"min\":1\
    },\
    \"CalculateRouteMatrixSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DataSource\",\
        \"DistanceUnit\",\
        \"ErrorCount\",\
        \"RouteCount\"\
      ],\
      \"members\":{\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The data provider of traffic and road network data used to calculate the routes. Indicates one of the available providers:</p> <ul> <li> <p> <code>Esri</code> </p> </li> <li> <p> <code>Grab</code> </p> </li> <li> <p> <code>Here</code> </p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"DistanceUnit\":{\
          \"shape\":\"DistanceUnit\",\
          \"documentation\":\"<p>The unit of measurement for route distances.</p>\"\
        },\
        \"ErrorCount\":{\
          \"shape\":\"CalculateRouteMatrixSummaryErrorCountInteger\",\
          \"documentation\":\"<p>The count of error results in the route matrix. If this number is 0, all routes were calculated successfully.</p>\"\
        },\
        \"RouteCount\":{\
          \"shape\":\"CalculateRouteMatrixSummaryRouteCountInteger\",\
          \"documentation\":\"<p>The count of cells in the route matrix. Equal to the number of <code>DeparturePositions</code> multiplied by the number of <code>DestinationPositions</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A summary of the calculated route matrix.</p>\"\
    },\
    \"CalculateRouteMatrixSummaryErrorCountInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":160000,\
      \"min\":1\
    },\
    \"CalculateRouteMatrixSummaryRouteCountInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":160000,\
      \"min\":1\
    },\
    \"CalculateRouteRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorName\",\
        \"DeparturePosition\",\
        \"DestinationPosition\"\
      ],\
      \"members\":{\
        \"ArrivalTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specifies the desired time of arrival. Uses the given time to calculate the route. Otherwise, the best time of day to travel with the best traffic conditions is used to calculate the route.</p> <note> <p>ArrivalTime is not supported Esri.</p> </note>\"\
        },\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource that you want to use to calculate the route. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CalculatorName\"\
        },\
        \"CarModeOptions\":{\
          \"shape\":\"CalculateRouteCarModeOptions\",\
          \"documentation\":\"<p>Specifies route preferences when traveling by <code>Car</code>, such as avoiding routes that use ferries or tolls.</p> <p>Requirements: <code>TravelMode</code> must be specified as <code>Car</code>.</p>\"\
        },\
        \"DepartNow\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Sets the time of departure as the current time. Uses the current time to calculate a route. Otherwise, the best time of day to travel with the best traffic conditions is used to calculate the route.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        },\
        \"DeparturePosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The start position for the route. Defined in <a href=\\\"https://earth-info.nga.mil/index.php?dir=wgs84&amp;action=wgs84\\\">World Geodetic System (WGS 84)</a> format: <code>[longitude, latitude]</code>.</p> <ul> <li> <p>For example, <code>[-123.115, 49.285]</code> </p> </li> </ul> <note> <p>If you specify a departure that's not located on a road, Amazon Location <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\">moves the position to the nearest road</a>. If Esri is the provider for your route calculator, specifying a route that is longer than 400 km returns a <code>400 RoutesValidationException</code> error.</p> </note> <p>Valid Values: <code>[-180 to 180,-90 to 90]</code> </p>\"\
        },\
        \"DepartureTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specifies the desired time of departure. Uses the given time to calculate the route. Otherwise, the best time of day to travel with the best traffic conditions is used to calculate the route.</p> <ul> <li> <p>In <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        },\
        \"DestinationPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The finish position for the route. Defined in <a href=\\\"https://earth-info.nga.mil/index.php?dir=wgs84&amp;action=wgs84\\\">World Geodetic System (WGS 84)</a> format: <code>[longitude, latitude]</code>.</p> <ul> <li> <p> For example, <code>[-122.339, 47.615]</code> </p> </li> </ul> <note> <p>If you specify a destination that's not located on a road, Amazon Location <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\">moves the position to the nearest road</a>. </p> </note> <p>Valid Values: <code>[-180 to 180,-90 to 90]</code> </p>\"\
        },\
        \"DistanceUnit\":{\
          \"shape\":\"DistanceUnit\",\
          \"documentation\":\"<p>Set the unit system to specify the distance.</p> <p>Default Value: <code>Kilometers</code> </p>\"\
        },\
        \"IncludeLegGeometry\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Set to include the geometry details in the result for each path between a pair of positions.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"OptimizeFor\":{\
          \"shape\":\"OptimizationMode\",\
          \"documentation\":\"<p>Specifies the distance to optimize for when calculating a route.</p>\"\
        },\
        \"TravelMode\":{\
          \"shape\":\"TravelMode\",\
          \"documentation\":\"<p>Specifies the mode of transport when calculating a route. Used in estimating the speed of travel and road compatibility. You can choose <code>Car</code>, <code>Truck</code>, <code>Walking</code>, <code>Bicycle</code> or <code>Motorcycle</code> as options for the <code>TravelMode</code>.</p> <note> <p> <code>Bicycle</code> and <code>Motorcycle</code> are only valid when using Grab as a data provider, and only within Southeast Asia.</p> <p> <code>Truck</code> is not available for Grab.</p> <p>For more details on the using Grab for routing, including areas of coverage, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html\\\">GrabMaps</a> in the <i>Amazon Location Service Developer Guide</i>.</p> </note> <p>The <code>TravelMode</code> you specify also determines how you specify route preferences: </p> <ul> <li> <p>If traveling by <code>Car</code> use the <code>CarModeOptions</code> parameter.</p> </li> <li> <p>If traveling by <code>Truck</code> use the <code>TruckModeOptions</code> parameter.</p> </li> </ul> <p>Default Value: <code>Car</code> </p>\"\
        },\
        \"TruckModeOptions\":{\
          \"shape\":\"CalculateRouteTruckModeOptions\",\
          \"documentation\":\"<p>Specifies route preferences when traveling by <code>Truck</code>, such as avoiding routes that use ferries or tolls, and truck specifications to consider when choosing an optimal road.</p> <p>Requirements: <code>TravelMode</code> must be specified as <code>Truck</code>.</p>\"\
        },\
        \"WaypointPositions\":{\
          \"shape\":\"CalculateRouteRequestWaypointPositionsList\",\
          \"documentation\":\"<p>Specifies an ordered list of up to 23 intermediate positions to include along a route between the departure position and destination position. </p> <ul> <li> <p>For example, from the <code>DeparturePosition</code> <code>[-123.115, 49.285]</code>, the route follows the order that the waypoint positions are given <code>[[-122.757, 49.0021],[-122.349, 47.620]]</code> </p> </li> </ul> <note> <p>If you specify a waypoint position that's not located on a road, Amazon Location <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\">moves the position to the nearest road</a>. </p> <p>Specifying more than 23 waypoints returns a <code>400 ValidationException</code> error.</p> <p>If Esri is the provider for your route calculator, specifying a route that is longer than 400 km returns a <code>400 RoutesValidationException</code> error.</p> </note> <p>Valid Values: <code>[-180 to 180,-90 to 90]</code> </p>\"\
        }\
      }\
    },\
    \"CalculateRouteRequestWaypointPositionsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"max\":23,\
      \"min\":0\
    },\
    \"CalculateRouteResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Legs\",\
        \"Summary\"\
      ],\
      \"members\":{\
        \"Legs\":{\
          \"shape\":\"LegList\",\
          \"documentation\":\"<p>Contains details about each path between a pair of positions included along a route such as: <code>StartPosition</code>, <code>EndPosition</code>, <code>Distance</code>, <code>DurationSeconds</code>, <code>Geometry</code>, and <code>Steps</code>. The number of legs returned corresponds to one fewer than the total number of positions in the request. </p> <p>For example, a route with a departure position and destination position returns one leg with the positions <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\">snapped to a nearby road</a>:</p> <ul> <li> <p>The <code>StartPosition</code> is the departure position.</p> </li> <li> <p>The <code>EndPosition</code> is the destination position.</p> </li> </ul> <p>A route with a waypoint between the departure and destination position returns two legs with the positions snapped to a nearby road:</p> <ul> <li> <p>Leg 1: The <code>StartPosition</code> is the departure position . The <code>EndPosition</code> is the waypoint positon.</p> </li> <li> <p>Leg 2: The <code>StartPosition</code> is the waypoint position. The <code>EndPosition</code> is the destination position.</p> </li> </ul>\"\
        },\
        \"Summary\":{\
          \"shape\":\"CalculateRouteSummary\",\
          \"documentation\":\"<p>Contains information about the whole route, such as: <code>RouteBBox</code>, <code>DataSource</code>, <code>Distance</code>, <code>DistanceUnit</code>, and <code>DurationSeconds</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Returns the result of the route calculation. Metadata includes legs and route summary.</p>\"\
    },\
    \"CalculateRouteSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DataSource\",\
        \"Distance\",\
        \"DistanceUnit\",\
        \"DurationSeconds\",\
        \"RouteBBox\"\
      ],\
      \"members\":{\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The data provider of traffic and road network data used to calculate the route. Indicates one of the available providers:</p> <ul> <li> <p> <code>Esri</code> </p> </li> <li> <p> <code>Grab</code> </p> </li> <li> <p> <code>Here</code> </p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"Distance\":{\
          \"shape\":\"CalculateRouteSummaryDistanceDouble\",\
          \"documentation\":\"<p>The total distance covered by the route. The sum of the distance travelled between every stop on the route.</p> <note> <p>If Esri is the data source for the route calculator, the route distance canât be greater than 400 km. If the route exceeds 400 km, the response is a <code>400 RoutesValidationException</code> error.</p> </note>\"\
        },\
        \"DistanceUnit\":{\
          \"shape\":\"DistanceUnit\",\
          \"documentation\":\"<p>The unit of measurement for route distances.</p>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"CalculateRouteSummaryDurationSecondsDouble\",\
          \"documentation\":\"<p>The total travel time for the route measured in seconds. The sum of the travel time between every stop on the route.</p>\"\
        },\
        \"RouteBBox\":{\
          \"shape\":\"BoundingBox\",\
          \"documentation\":\"<p>Specifies a geographical box surrounding a route. Used to zoom into a route when displaying it in a map. For example, <code>[min x, min y, max x, max y]</code>.</p> <p>The first 2 <code>bbox</code> parameters describe the lower southwest corner: </p> <ul> <li> <p>The first <code>bbox</code> position is the X coordinate or longitude of the lower southwest corner. </p> </li> <li> <p>The second <code>bbox</code> position is the Y coordinate or latitude of the lower southwest corner. </p> </li> </ul> <p>The next 2 <code>bbox</code> parameters describe the upper northeast corner: </p> <ul> <li> <p>The third <code>bbox</code> position is the X coordinate, or longitude of the upper northeast corner. </p> </li> <li> <p>The fourth <code>bbox</code> position is the Y coordinate, or latitude of the upper northeast corner. </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>A summary of the calculated route.</p>\"\
    },\
    \"CalculateRouteSummaryDistanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"CalculateRouteSummaryDurationSecondsDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"CalculateRouteTruckModeOptions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AvoidFerries\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Avoids ferries when calculating routes.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        },\
        \"AvoidTolls\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Avoids tolls when calculating routes.</p> <p>Default Value: <code>false</code> </p> <p>Valid Values: <code>false</code> | <code>true</code> </p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"TruckDimensions\",\
          \"documentation\":\"<p>Specifies the truck's dimension specifications including length, height, width, and unit of measurement. Used to avoid roads that can't support the truck's dimensions.</p>\"\
        },\
        \"Weight\":{\
          \"shape\":\"TruckWeight\",\
          \"documentation\":\"<p>Specifies the truck's weight specifications including total weight and unit of measurement. Used to avoid roads that can't support the truck's weight.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details about additional route preferences for requests that specify <code>TravelMode</code> as <code>Truck</code>.</p>\"\
    },\
    \"Circle\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Center\",\
        \"Radius\"\
      ],\
      \"members\":{\
        \"Center\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>A single point geometry, specifying the center of the circle, using <a href=\\\"https://gisgeography.com/wgs84-world-geodetic-system/\\\">WGS 84</a> coordinates, in the form <code>[longitude, latitude]</code>.</p>\"\
        },\
        \"Radius\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>The radius of the circle in meters. Must be greater than zero and no larger than 100,000 (100 kilometers).</p>\"\
        }\
      },\
      \"documentation\":\"<p>A circle on the earth, as defined by a center point and a radius.</p>\",\
      \"sensitive\":true\
    },\
    \"ConflictException\":{\
      \"type\":\"structure\",\
      \"required\":[\"Message\"],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"locationName\":\"message\"\
        }\
      },\
      \"documentation\":\"<p>The request was unsuccessful because of a conflict.</p>\",\
      \"error\":{\
        \"httpStatusCode\":409,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"CountryCode\":{\
      \"type\":\"string\",\
      \"pattern\":\"^[A-Z]{3}$\"\
    },\
    \"CountryCode3\":{\
      \"type\":\"string\",\
      \"max\":3,\
      \"min\":3,\
      \"pattern\":\"^[A-Z]{3}$\"\
    },\
    \"CountryCode3OrEmpty\":{\
      \"type\":\"string\",\
      \"max\":3,\
      \"min\":0,\
      \"pattern\":\"^[A-Z]{3}$|^$\"\
    },\
    \"CountryCodeList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CountryCode\"},\
      \"max\":100,\
      \"min\":1\
    },\
    \"CreateGeofenceCollectionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CollectionName\"],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>A custom name for the geofence collection.</p> <p>Requirements:</p> <ul> <li> <p>Contain only alphanumeric characters (AâZ, aâz, 0â9), hyphens (-), periods (.), and underscores (_). </p> </li> <li> <p>Must be a unique geofence collection name.</p> </li> <li> <p>No spaces allowed. For example, <code>ExampleGeofenceCollection</code>.</p> </li> </ul>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>An optional description for the geofence collection.</p>\"\
        },\
        \"KmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>A key identifier for an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a>. Enter a key ID, key ARN, alias name, or alias ARN. </p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter is no longer used.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. No longer allowed.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to the geofence collection. A tag is a key-value pair helps manage, identify, search, and filter your resources by labelling them.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource</p> </li> <li> <p>Each resource tag must be unique with a maximum of one value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @. </p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreateGeofenceCollectionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionArn\",\
        \"CollectionName\",\
        \"CreateTime\"\
      ],\
      \"members\":{\
        \"CollectionArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the geofence collection resource. Used when you need to specify a resource across all Amazon Web Services. </p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollection</code> </p> </li> </ul>\"\
        },\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name for the geofence collection.</p>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence collection was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      }\
    },\
    \"CreateKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyName\",\
        \"Restrictions\"\
      ],\
      \"members\":{\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>An optional description for the API key resource.</p>\"\
        },\
        \"ExpireTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The optional timestamp for when the API key resource will expire in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. One of <code>NoExpiry</code> or <code>ExpireTime</code> must be set.</p>\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>A custom name for the API key resource.</p> <p>Requirements:</p> <ul> <li> <p>Contain only alphanumeric characters (AâZ, aâz, 0â9), hyphens (-), periods (.), and underscores (_). </p> </li> <li> <p>Must be a unique API key name.</p> </li> <li> <p>No spaces allowed. For example, <code>ExampleAPIKey</code>.</p> </li> </ul>\"\
        },\
        \"NoExpiry\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Optionally set to <code>true</code> to set no expiration time for the API key. One of <code>NoExpiry</code> or <code>ExpireTime</code> must be set.</p>\"\
        },\
        \"Restrictions\":{\
          \"shape\":\"ApiKeyRestrictions\",\
          \"documentation\":\"<p>The API key restrictions for the API key resource.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to the map resource. A tag is a key-value pair that helps manage, identify, search, and filter your resources by labelling them.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource</p> </li> <li> <p>Each resource tag must be unique with a maximum of one value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @. </p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreateKeyResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"Key\",\
        \"KeyArn\",\
        \"KeyName\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the API key resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The key value/string of an API key. This value is used when making API calls to authorize the call. For example, see <a href=\\\"https://docs.aws.amazon.com/location/latest/APIReference/API_GetMapGlyphs.html\\\">GetMapGlyphs</a>.</p>\"\
        },\
        \"KeyArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the API key resource. Used when you need to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:key/ExampleKey</code> </p> </li> </ul>\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key resource.</p>\"\
        }\
      }\
    },\
    \"CreateMapRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Configuration\",\
        \"MapName\"\
      ],\
      \"members\":{\
        \"Configuration\":{\
          \"shape\":\"MapConfiguration\",\
          \"documentation\":\"<p>Specifies the <code>MapConfiguration</code>, including the map style, for the map resource that you create. The map style defines the look of maps and the data provider for your map resource.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>An optional description for the map resource.</p>\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name for the map resource.</p> <p>Requirements:</p> <ul> <li> <p>Must contain only alphanumeric characters (AâZ, aâz, 0â9), hyphens (-), periods (.), and underscores (_). </p> </li> <li> <p>Must be a unique map resource name. </p> </li> <li> <p>No spaces allowed. For example, <code>ExampleMap</code>.</p> </li> </ul>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to the map resource. A tag is a key-value pair helps manage, identify, search, and filter your resources by labelling them.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource</p> </li> <li> <p>Each resource tag must be unique with a maximum of one value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @. </p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreateMapResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"MapArn\",\
        \"MapName\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the map resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        },\
        \"MapArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the map resource. Used to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:map/ExampleMap</code> </p> </li> </ul>\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the map resource.</p>\"\
        }\
      }\
    },\
    \"CreatePlaceIndexRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DataSource\",\
        \"IndexName\"\
      ],\
      \"members\":{\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Specifies the geospatial data provider for the new place index.</p> <note> <p>This field is case-sensitive. Enter the valid values as shown. For example, entering <code>HERE</code> returns an error.</p> </note> <p>Valid values include:</p> <ul> <li> <p> <code>Esri</code> â For additional information about <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/esri.html\\\">Esri</a>'s coverage in your region of interest, see <a href=\\\"https://developers.arcgis.com/rest/geocode/api-reference/geocode-coverage.htm\\\">Esri details on geocoding coverage</a>.</p> </li> <li> <p> <code>Grab</code> â Grab provides place index functionality for Southeast Asia. For additional information about <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html\\\">GrabMaps</a>' coverage, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html#grab-coverage-area\\\">GrabMaps countries and areas covered</a>.</p> </li> <li> <p> <code>Here</code> â For additional information about <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/HERE.html\\\">HERE Technologies</a>' coverage in your region of interest, see <a href=\\\"https://developer.here.com/documentation/geocoder/dev_guide/topics/coverage-geocoder.html\\\">HERE details on goecoding coverage</a>.</p> <important> <p>If you specify HERE Technologies (<code>Here</code>) as the data provider, you may not <a href=\\\"https://docs.aws.amazon.com/location-places/latest/APIReference/API_DataSourceConfiguration.html\\\">store results</a> for locations in Japan. For more information, see the <a href=\\\"http://aws.amazon.com/service-terms/\\\">Amazon Web Services Service Terms</a> for Amazon Location Service.</p> </important> </li> </ul> <p>For additional information , see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Data providers</a> on the <i>Amazon Location Service Developer Guide</i>.</p>\"\
        },\
        \"DataSourceConfiguration\":{\
          \"shape\":\"DataSourceConfiguration\",\
          \"documentation\":\"<p>Specifies the data storage option requesting Places.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the place index resource.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource. </p> <p>Requirements:</p> <ul> <li> <p>Contain only alphanumeric characters (AâZ, aâz, 0â9), hyphens (-), periods (.), and underscores (_).</p> </li> <li> <p>Must be a unique place index resource name.</p> </li> <li> <p>No spaces allowed. For example, <code>ExamplePlaceIndex</code>.</p> </li> </ul>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to the place index resource. A tag is a key-value pair that helps you manage, identify, search, and filter your resources.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource.</p> </li> <li> <p>Each tag key must be unique and must have exactly one associated value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8.</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8.</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @</p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreatePlaceIndexResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"IndexArn\",\
        \"IndexName\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the place index resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"IndexArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the place index resource. Used to specify a resource across Amazon Web Services. </p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:place-index/ExamplePlaceIndex</code> </p> </li> </ul>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name for the place index resource.</p>\"\
        }\
      }\
    },\
    \"CreateRouteCalculatorRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorName\",\
        \"DataSource\"\
      ],\
      \"members\":{\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource. </p> <p>Requirements:</p> <ul> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9) , hyphens (-), periods (.), and underscores (_).</p> </li> <li> <p>Must be a unique Route calculator resource name.</p> </li> <li> <p>No spaces allowed. For example, <code>ExampleRouteCalculator</code>.</p> </li> </ul>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Specifies the data provider of traffic and road network data.</p> <note> <p>This field is case-sensitive. Enter the valid values as shown. For example, entering <code>HERE</code> returns an error.</p> </note> <p>Valid values include:</p> <ul> <li> <p> <code>Esri</code> â For additional information about <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/esri.html\\\">Esri</a>'s coverage in your region of interest, see <a href=\\\"https://doc.arcgis.com/en/arcgis-online/reference/network-coverage.htm\\\">Esri details on street networks and traffic coverage</a>.</p> <p>Route calculators that use Esri as a data source only calculate routes that are shorter than 400 km.</p> </li> <li> <p> <code>Grab</code> â Grab provides routing functionality for Southeast Asia. For additional information about <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html\\\">GrabMaps</a>' coverage, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html#grab-coverage-area\\\">GrabMaps countries and areas covered</a>.</p> </li> <li> <p> <code>Here</code> â For additional information about <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/HERE.html\\\">HERE Technologies</a>' coverage in your region of interest, see <a href=\\\"https://developer.here.com/documentation/routing-api/dev_guide/topics/coverage/car-routing.html\\\">HERE car routing coverage</a> and <a href=\\\"https://developer.here.com/documentation/routing-api/dev_guide/topics/coverage/truck-routing.html\\\">HERE truck routing coverage</a>.</p> </li> </ul> <p>For additional information , see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Data providers</a> on the <i>Amazon Location Service Developer Guide</i>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the route calculator resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to the route calculator resource. A tag is a key-value pair helps manage, identify, search, and filter your resources by labelling them.</p> <ul> <li> <p>For example: { <code>\\\"tag1\\\" : \\\"value1\\\"</code>, <code>\\\"tag2\\\" : \\\"value2\\\"</code>}</p> </li> </ul> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource</p> </li> <li> <p>Each resource tag must be unique with a maximum of one value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @. </p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreateRouteCalculatorResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorArn\",\
        \"CalculatorName\",\
        \"CreateTime\"\
      ],\
      \"members\":{\
        \"CalculatorArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the route calculator resource. Use the ARN when you specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:route-calculator/ExampleCalculator</code> </p> </li> </ul>\"\
        },\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource. </p> <ul> <li> <p>For example, <code>ExampleRouteCalculator</code>.</p> </li> </ul>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp when the route calculator resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p> <ul> <li> <p>For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreateTrackerRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"TrackerName\"],\
      \"members\":{\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>An optional description for the tracker resource.</p>\"\
        },\
        \"EventBridgeEnabled\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Whether to enable position <code>UPDATE</code> events from this tracker to be sent to EventBridge.</p> <note> <p>You do not need enable this feature to get <code>ENTER</code> and <code>EXIT</code> events for geofences with this tracker. Those events are always sent to EventBridge.</p> </note>\"\
        },\
        \"KmsKeyEnableGeospatialQueries\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Enables <code>GeospatialQueries</code> for a tracker that uses a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a>.</p> <p>This parameter is only used if you are using a KMS customer managed key.</p> <note> <p>If you wish to encrypt your data using your own KMS customer managed key, then the Bounding Polygon Queries feature will be disabled by default. This is because by using this feature, a representation of your device positions will not be encrypted using the your KMS managed key. The exact device position, however; is still encrypted using your managed key.</p> <p>You can choose to opt-in to the Bounding Polygon Quseries feature. This is done by setting the <code>KmsKeyEnableGeospatialQueries</code> parameter to true when creating or updating a Tracker.</p> </note>\"\
        },\
        \"KmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>A key identifier for an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a>. Enter a key ID, key ARN, alias name, or alias ARN.</p>\"\
        },\
        \"PositionFiltering\":{\
          \"shape\":\"PositionFiltering\",\
          \"documentation\":\"<p>Specifies the position filtering for the tracker resource.</p> <p>Valid values:</p> <ul> <li> <p> <code>TimeBased</code> - Location updates are evaluated against linked geofence collections, but not every location update is stored. If your update frequency is more often than 30 seconds, only one update per 30 seconds is stored for each unique device ID. </p> </li> <li> <p> <code>DistanceBased</code> - If the device has moved less than 30 m (98.4 ft), location updates are ignored. Location updates within this area are neither evaluated against linked geofence collections, nor stored. This helps control costs by reducing the number of geofence evaluations and historical device positions to paginate through. Distance-based filtering can also reduce the effects of GPS noise when displaying device trajectories on a map. </p> </li> <li> <p> <code>AccuracyBased</code> - If the device has moved less than the measured accuracy, location updates are ignored. For example, if two consecutive updates from a device have a horizontal accuracy of 5 m and 10 m, the second update is ignored if the device has moved less than 15 m. Ignored location updates are neither evaluated against linked geofence collections, nor stored. This can reduce the effects of GPS noise when displaying device trajectories on a map, and can help control your costs by reducing the number of geofence evaluations. </p> </li> </ul> <p>This field is optional. If not specified, the default value is <code>TimeBased</code>.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter is no longer used.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. No longer allowed.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to the tracker resource. A tag is a key-value pair helps manage, identify, search, and filter your resources by labelling them.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource</p> </li> <li> <p>Each resource tag must be unique with a maximum of one value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @. </p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name for the tracker resource.</p> <p>Requirements:</p> <ul> <li> <p>Contain only alphanumeric characters (A-Z, a-z, 0-9) , hyphens (-), periods (.), and underscores (_).</p> </li> <li> <p>Must be a unique tracker resource name.</p> </li> <li> <p>No spaces allowed. For example, <code>ExampleTracker</code>.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"CreateTrackerResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"TrackerArn\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"TrackerArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the tracker resource. Used when you need to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:tracker/ExampleTracker</code> </p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource.</p>\"\
        }\
      }\
    },\
    \"DataSourceConfiguration\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"IntendedUse\":{\
          \"shape\":\"IntendedUse\",\
          \"documentation\":\"<p>Specifies how the results of an operation will be stored by the caller. </p> <p>Valid values include:</p> <ul> <li> <p> <code>SingleUse</code> specifies that the results won't be stored. </p> </li> <li> <p> <code>Storage</code> specifies that the result can be cached or stored in a database.</p> </li> </ul> <p>Default value: <code>SingleUse</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the data storage option chosen for requesting Places.</p> <important> <p>When using Amazon Location Places:</p> <ul> <li> <p>If using HERE Technologies as a data provider, you can't store results for locations in Japan by setting <code>IntendedUse</code> to <code>Storage</code>. parameter.</p> </li> <li> <p>Under the <code>MobileAssetTracking</code> or <code>MobilAssetManagement</code> pricing plan, you can't store results from your place index resources by setting <code>IntendedUse</code> to <code>Storage</code>. This returns a validation exception error.</p> </li> </ul> <p>For more information, see the <a href=\\\"https://aws.amazon.com/service-terms/\\\">AWS Service Terms</a> for Amazon Location Service.</p> </important>\"\
    },\
    \"DeleteGeofenceCollectionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CollectionName\"],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the geofence collection to be deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        }\
      }\
    },\
    \"DeleteGeofenceCollectionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeleteKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyName\"],\
      \"members\":{\
        \"ForceDelete\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>ForceDelete bypasses an API key's expiry conditions and deletes the key. Set the parameter <code>true</code> to delete the key or to <code>false</code> to not preemptively delete the API key.</p> <p>Valid values: <code>true</code>, or <code>false</code>.</p> <p>Required: No</p> <note> <p>This action is irreversible. Only use ForceDelete if you are certain the key is no longer in use.</p> </note>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"forceDelete\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key to delete.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"KeyName\"\
        }\
      }\
    },\
    \"DeleteKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeleteMapRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"MapName\"],\
      \"members\":{\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the map resource to be deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        }\
      }\
    },\
    \"DeleteMapResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeletePlaceIndexRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource to be deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        }\
      }\
    },\
    \"DeletePlaceIndexResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeleteRouteCalculatorRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CalculatorName\"],\
      \"members\":{\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource to be deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CalculatorName\"\
        }\
      }\
    },\
    \"DeleteRouteCalculatorResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeleteTrackerRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"TrackerName\"],\
      \"members\":{\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource to be deleted.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"DeleteTrackerResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DescribeGeofenceCollectionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CollectionName\"],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the geofence collection.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        }\
      }\
    },\
    \"DescribeGeofenceCollectionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionArn\",\
        \"CollectionName\",\
        \"CreateTime\",\
        \"Description\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CollectionArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the geofence collection resource. Used when you need to specify a resource across all Amazon Web Services. </p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollection</code> </p> </li> </ul>\"\
        },\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the geofence collection.</p>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the geofence collection.</p>\"\
        },\
        \"GeofenceCount\":{\
          \"shape\":\"DescribeGeofenceCollectionResponseGeofenceCountInteger\",\
          \"documentation\":\"<p>The number of geofences in the geofence collection.</p>\"\
        },\
        \"KmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>A key identifier for an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a> assigned to the Amazon Location resource</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>No longer used. Always returns an empty string.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Unused.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Displays the key, value pairs of tags associated with this resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence collection was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      }\
    },\
    \"DescribeGeofenceCollectionResponseGeofenceCountInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"DescribeKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyName\"],\
      \"members\":{\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key resource.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"KeyName\"\
        }\
      }\
    },\
    \"DescribeKeyResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"ExpireTime\",\
        \"Key\",\
        \"KeyArn\",\
        \"KeyName\",\
        \"Restrictions\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the API key resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the API key resource.</p>\"\
        },\
        \"ExpireTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the API key resource will expire in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The key value/string of an API key.</p>\"\
        },\
        \"KeyArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the API key resource. Used when you need to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:key/ExampleKey</code> </p> </li> </ul>\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key resource.</p>\"\
        },\
        \"Restrictions\":{\"shape\":\"ApiKeyRestrictions\"},\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Tags associated with the API key resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the API key resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"DescribeMapRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"MapName\"],\
      \"members\":{\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the map resource.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        }\
      }\
    },\
    \"DescribeMapResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Configuration\",\
        \"CreateTime\",\
        \"DataSource\",\
        \"Description\",\
        \"MapArn\",\
        \"MapName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"Configuration\":{\
          \"shape\":\"MapConfiguration\",\
          \"documentation\":\"<p>Specifies the map tile style selected from a partner data provider.</p>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the map resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Specifies the data provider for the associated map tiles.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the map resource.</p>\"\
        },\
        \"MapArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the map resource. Used to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:map/ExampleMap</code> </p> </li> </ul>\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The map style selected from an available provider.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Tags associated with the map resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the map resource was last update in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        }\
      }\
    },\
    \"DescribePlaceIndexRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        }\
      }\
    },\
    \"DescribePlaceIndexResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"DataSource\",\
        \"DataSourceConfiguration\",\
        \"Description\",\
        \"IndexArn\",\
        \"IndexName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the place index resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The data provider of geospatial data. Values can be one of the following:</p> <ul> <li> <p> <code>Esri</code> </p> </li> <li> <p> <code>Grab</code> </p> </li> <li> <p> <code>Here</code> </p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"DataSourceConfiguration\":{\
          \"shape\":\"DataSourceConfiguration\",\
          \"documentation\":\"<p>The specified data storage option for requesting Places.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the place index resource.</p>\"\
        },\
        \"IndexArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the place index resource. Used to specify a resource across Amazon Web Services. </p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:place-index/ExamplePlaceIndex</code> </p> </li> </ul>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource being described.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Tags associated with place index resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the place index resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"DescribeRouteCalculatorRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CalculatorName\"],\
      \"members\":{\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CalculatorName\"\
        }\
      }\
    },\
    \"DescribeRouteCalculatorResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorArn\",\
        \"CalculatorName\",\
        \"CreateTime\",\
        \"DataSource\",\
        \"Description\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CalculatorArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the Route calculator resource. Use the ARN when you specify a resource across Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:route-calculator/ExampleCalculator</code> </p> </li> </ul>\"\
        },\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource being described.</p>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp when the route calculator resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p> <ul> <li> <p>For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The data provider of traffic and road network data. Indicates one of the available providers:</p> <ul> <li> <p> <code>Esri</code> </p> </li> <li> <p> <code>Grab</code> </p> </li> <li> <p> <code>Here</code> </p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description of the route calculator resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Tags associated with route calculator resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp when the route calculator resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p> <ul> <li> <p>For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        }\
      }\
    },\
    \"DescribeTrackerRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"TrackerName\"],\
      \"members\":{\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"DescribeTrackerResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"Description\",\
        \"TrackerArn\",\
        \"TrackerName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the tracker resource.</p>\"\
        },\
        \"EventBridgeEnabled\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Whether <code>UPDATE</code> events from this tracker in EventBridge are enabled. If set to <code>true</code> these events will be sent to EventBridge.</p>\"\
        },\
        \"KmsKeyEnableGeospatialQueries\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Enables <code>GeospatialQueries</code> for a tracker that uses a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a>.</p> <p>This parameter is only used if you are using a KMS customer managed key.</p> <note> <p>If you wish to encrypt your data using your own KMS customer managed key, then the Bounding Polygon Queries feature will be disabled by default. This is because by using this feature, a representation of your device positions will not be encrypted using the your KMS managed key. The exact device position, however; is still encrypted using your managed key.</p> <p>You can choose to opt-in to the Bounding Polygon Quseries feature. This is done by setting the <code>KmsKeyEnableGeospatialQueries</code> parameter to true when creating or updating a Tracker.</p> </note>\"\
        },\
        \"KmsKeyId\":{\
          \"shape\":\"KmsKeyId\",\
          \"documentation\":\"<p>A key identifier for an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a> assigned to the Amazon Location resource.</p>\"\
        },\
        \"PositionFiltering\":{\
          \"shape\":\"PositionFiltering\",\
          \"documentation\":\"<p>The position filtering method of the tracker resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>No longer used. Always returns an empty string.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Unused.\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>The tags associated with the tracker resource.</p>\"\
        },\
        \"TrackerArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the tracker resource. Used when you need to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:tracker/ExampleTracker</code> </p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"DevicePosition\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Position\",\
        \"ReceivedTime\",\
        \"SampleTime\"\
      ],\
      \"members\":{\
        \"Accuracy\":{\
          \"shape\":\"PositionalAccuracy\",\
          \"documentation\":\"<p>The accuracy of the device position.</p>\"\
        },\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device whose position you retrieved.</p>\"\
        },\
        \"Position\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The last known device position.</p>\"\
        },\
        \"PositionProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>The properties associated with the position.</p>\"\
        },\
        \"ReceivedTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource received the device position in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"SampleTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp at which the device's position was determined. Uses <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the device position details.</p>\"\
    },\
    \"DevicePositionList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DevicePosition\"}\
    },\
    \"DevicePositionUpdate\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"Position\",\
        \"SampleTime\"\
      ],\
      \"members\":{\
        \"Accuracy\":{\
          \"shape\":\"PositionalAccuracy\",\
          \"documentation\":\"<p>The accuracy of the device position.</p>\"\
        },\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device associated to the position update.</p>\"\
        },\
        \"Position\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The latest device position defined in <a href=\\\"https://earth-info.nga.mil/index.php?dir=wgs84&amp;action=wgs84\\\">WGS 84</a> format: <code>[X or longitude, Y or latitude]</code>.</p>\"\
        },\
        \"PositionProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>Associates one of more properties with the position update. A property is a key-value pair stored with the position update and added to any geofence event the update may trigger.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p>\"\
        },\
        \"SampleTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp at which the device's position was determined. Uses <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the position update details for a device.</p>\"\
    },\
    \"DimensionUnit\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Meters\",\
        \"Feet\"\
      ]\
    },\
    \"DisassociateTrackerConsumerRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ConsumerArn\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"ConsumerArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the geofence collection to be disassociated from the tracker resource. Used when you need to specify a resource across all Amazon Web Services. </p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollectionConsumer</code> </p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"ConsumerArn\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource to be dissociated from the consumer.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"DisassociateTrackerConsumerResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DistanceUnit\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Kilometers\",\
        \"Miles\"\
      ]\
    },\
    \"Double\":{\
      \"type\":\"double\",\
      \"box\":true\
    },\
    \"FilterPlaceCategoryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PlaceCategory\"},\
      \"max\":5,\
      \"min\":1\
    },\
    \"GeoArn\":{\
      \"type\":\"string\",\
      \"max\":1600,\
      \"min\":0,\
      \"pattern\":\"^arn(:[a-z0-9]+([.-][a-z0-9]+)*):geo(:([a-z0-9]+([.-][a-z0-9]+)*))(:[0-9]+):((\\\\*)|([-a-z]+[/][*-._\\\\w]+))$\"\
    },\
    \"GeofenceGeometry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Circle\":{\
          \"shape\":\"Circle\",\
          \"documentation\":\"<p>A circle on the earth, as defined by a center point and a radius.</p>\"\
        },\
        \"Polygon\":{\
          \"shape\":\"LinearRings\",\
          \"documentation\":\"<p>A polygon is a list of linear rings which are each made up of a list of vertices.</p> <p>Each vertex is a 2-dimensional point of the form: <code>[longitude, latitude]</code>. This is represented as an array of doubles of length 2 (so <code>[double, double]</code>).</p> <p>An array of 4 or more vertices, where the first and last vertex are the same (to form a closed boundary), is called a linear ring. The linear ring vertices must be listed in counter-clockwise order around the ringâs interior. The linear ring is represented as an array of vertices, or an array of arrays of doubles (<code>[[double, double], ...]</code>).</p> <p>A geofence consists of a single linear ring. To allow for future expansion, the Polygon parameter takes an array of linear rings, which is represented as an array of arrays of arrays of doubles (<code>[[[double, double], ...], ...]</code>).</p> <p>A linear ring for use in geofences can consist of between 4 and 1,000 vertices.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the geofence geometry details.</p> <p>A geofence geometry is made up of either a polygon or a circle. Can be either a polygon or a circle. Including both will return a validation error.</p> <note> <p>Amazon Location doesn't currently support polygons with holes, multipolygons, polygons that are wound clockwise, or that cross the antimeridian. </p> </note>\"\
    },\
    \"GetDevicePositionHistoryRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device whose position history you want to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"DeviceId\"\
        },\
        \"EndTimeExclusive\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specify the end time for the position history in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. By default, the value will be the time that the request is made.</p> <p>Requirement:</p> <ul> <li> <p>The time specified for <code>EndTimeExclusive</code> must be after the time for <code>StartTimeInclusive</code>.</p> </li> </ul>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"GetDevicePositionHistoryRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of device positions returned in a single call.</p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page. </p> <p>Default value: <code>null</code> </p>\"\
        },\
        \"StartTimeInclusive\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specify the start time for the position history in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. By default, the value will be 24 hours prior to the time that the request is made.</p> <p>Requirement:</p> <ul> <li> <p>The time specified for <code>StartTimeInclusive</code> must be before <code>EndTimeExclusive</code>.</p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The tracker resource receiving the request for the device position history.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"GetDevicePositionHistoryRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"GetDevicePositionHistoryResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"DevicePositions\"],\
      \"members\":{\
        \"DevicePositions\":{\
          \"shape\":\"DevicePositionList\",\
          \"documentation\":\"<p>Contains the position history details for the requested device.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results.</p>\"\
        }\
      }\
    },\
    \"GetDevicePositionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"TrackerName\"\
      ],\
      \"members\":{\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device whose position you want to retrieve.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"DeviceId\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The tracker resource receiving the position update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"GetDevicePositionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Position\",\
        \"ReceivedTime\",\
        \"SampleTime\"\
      ],\
      \"members\":{\
        \"Accuracy\":{\
          \"shape\":\"PositionalAccuracy\",\
          \"documentation\":\"<p>The accuracy of the device position.</p>\"\
        },\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The device whose position you retrieved.</p>\"\
        },\
        \"Position\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The last known device position.</p>\"\
        },\
        \"PositionProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>The properties associated with the position.</p>\"\
        },\
        \"ReceivedTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource received the device position in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601 </a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"SampleTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp at which the device's position was determined. Uses <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601 </a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"GetGeofenceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionName\",\
        \"GeofenceId\"\
      ],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The geofence collection storing the target geofence.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence you're retrieving details for.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"GeofenceId\"\
        }\
      }\
    },\
    \"GetGeofenceResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"GeofenceId\",\
        \"Geometry\",\
        \"Status\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence collection was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence identifier.</p>\"\
        },\
        \"GeofenceProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>User defined properties of the geofence. A property is a key-value pair stored with the geofence and added to any geofence event triggered with that geofence.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p>\"\
        },\
        \"Geometry\":{\
          \"shape\":\"GeofenceGeometry\",\
          \"documentation\":\"<p>Contains the geofence geometry details describing a polygon or a circle.</p>\"\
        },\
        \"Status\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Identifies the state of the geofence. A geofence will hold one of the following states:</p> <ul> <li> <p> <code>ACTIVE</code> â The geofence has been indexed by the system. </p> </li> <li> <p> <code>PENDING</code> â The geofence is being processed by the system.</p> </li> <li> <p> <code>FAILED</code> â The geofence failed to be indexed by the system.</p> </li> <li> <p> <code>DELETED</code> â The geofence has been deleted from the system index.</p> </li> <li> <p> <code>DELETING</code> â The geofence is being deleted from the system index.</p> </li> </ul>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence collection was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      }\
    },\
    \"GetMapGlyphsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FontStack\",\
        \"FontUnicodeRange\",\
        \"MapName\"\
      ],\
      \"members\":{\
        \"FontStack\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A comma-separated list of fonts to load glyphs from in order of preference. For example, <code>Noto Sans Regular, Arial Unicode</code>.</p> <p>Valid font stacks for <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/esri.html\\\">Esri</a> styles: </p> <ul> <li> <p>VectorEsriDarkGrayCanvas â <code>Ubuntu Medium Italic</code> | <code>Ubuntu Medium</code> | <code>Ubuntu Italic</code> | <code>Ubuntu Regular</code> | <code>Ubuntu Bold</code> </p> </li> <li> <p>VectorEsriLightGrayCanvas â <code>Ubuntu Italic</code> | <code>Ubuntu Regular</code> | <code>Ubuntu Light</code> | <code>Ubuntu Bold</code> </p> </li> <li> <p>VectorEsriTopographic â <code>Noto Sans Italic</code> | <code>Noto Sans Regular</code> | <code>Noto Sans Bold</code> | <code>Noto Serif Regular</code> | <code>Roboto Condensed Light Italic</code> </p> </li> <li> <p>VectorEsriStreets â <code>Arial Regular</code> | <code>Arial Italic</code> | <code>Arial Bold</code> </p> </li> <li> <p>VectorEsriNavigation â <code>Arial Regular</code> | <code>Arial Italic</code> | <code>Arial Bold</code> </p> </li> </ul> <p>Valid font stacks for <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/HERE.html\\\">HERE Technologies</a> styles:</p> <ul> <li> <p>VectorHereContrast â <code>Fira GO Regular</code> | <code>Fira GO Bold</code> </p> </li> <li> <p>VectorHereExplore, VectorHereExploreTruck, HybridHereExploreSatellite â <code>Fira GO Italic</code> | <code>Fira GO Map</code> | <code>Fira GO Map Bold</code> | <code>Noto Sans CJK JP Bold</code> | <code>Noto Sans CJK JP Light</code> | <code>Noto Sans CJK JP Regular</code> </p> </li> </ul> <p>Valid font stacks for <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html\\\">GrabMaps</a> styles:</p> <ul> <li> <p>VectorGrabStandardLight, VectorGrabStandardDark â <code>Noto Sans Regular</code> | <code>Noto Sans Medium</code> | <code>Noto Sans Bold</code> </p> </li> </ul> <p>Valid font stacks for <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/open-data.html\\\">Open Data</a> styles:</p> <ul> <li> <p>VectorOpenDataStandardLight, VectorOpenDataStandardDark, VectorOpenDataVisualizationLight, VectorOpenDataVisualizationDark â <code>Amazon Ember Regular,Noto Sans Regular</code> | <code>Amazon Ember Bold,Noto Sans Bold</code> | <code>Amazon Ember Medium,Noto Sans Medium</code> | <code>Amazon Ember Regular Italic,Noto Sans Italic</code> | <code>Amazon Ember Condensed RC Regular,Noto Sans Regular</code> | <code>Amazon Ember Condensed RC Bold,Noto Sans Bold</code> | <code>Amazon Ember Regular,Noto Sans Regular,Noto Sans Arabic Regular</code> | <code>Amazon Ember Condensed RC Bold,Noto Sans Bold,Noto Sans Arabic Condensed Bold</code> | <code>Amazon Ember Bold,Noto Sans Bold,Noto Sans Arabic Bold</code> | <code>Amazon Ember Regular Italic,Noto Sans Italic,Noto Sans Arabic Regular</code> | <code>Amazon Ember Condensed RC Regular,Noto Sans Regular,Noto Sans Arabic Condensed Regular</code> | <code>Amazon Ember Medium,Noto Sans Medium,Noto Sans Arabic Medium</code> </p> </li> </ul> <note> <p>The fonts used by the Open Data map styles are combined fonts that use <code>Amazon Ember</code> for most glyphs but <code>Noto Sans</code> for glyphs unsupported by <code>Amazon Ember</code>.</p> </note>\",\
          \"location\":\"uri\",\
          \"locationName\":\"FontStack\"\
        },\
        \"FontUnicodeRange\":{\
          \"shape\":\"GetMapGlyphsRequestFontUnicodeRangeString\",\
          \"documentation\":\"<p>A Unicode range of characters to download glyphs for. Each response will contain 256 characters. For example, 0â255 includes all characters from range <code>U+0000</code> to <code>00FF</code>. Must be aligned to multiples of 256.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"FontUnicodeRange\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The map resource associated with the glyph ï¬le.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        }\
      }\
    },\
    \"GetMapGlyphsRequestFontUnicodeRangeString\":{\
      \"type\":\"string\",\
      \"pattern\":\"^[0-9]+-[0-9]+\\\\.pbf$\"\
    },\
    \"GetMapGlyphsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Blob\":{\
          \"shape\":\"Blob\",\
          \"documentation\":\"<p>The glyph, as binary blob.</p>\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The HTTP Cache-Control directive for the value.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentType\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The map glyph content type. For example, <code>application/octet-stream</code>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        }\
      },\
      \"payload\":\"Blob\"\
    },\
    \"GetMapSpritesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FileName\",\
        \"MapName\"\
      ],\
      \"members\":{\
        \"FileName\":{\
          \"shape\":\"GetMapSpritesRequestFileNameString\",\
          \"documentation\":\"<p>The name of the sprite ï¬le. Use the following ï¬le names for the sprite sheet:</p> <ul> <li> <p> <code>sprites.png</code> </p> </li> <li> <p> <code>sprites@2x.png</code> for high pixel density displays</p> </li> </ul> <p>For the JSON document containing image offsets. Use the following ï¬le names:</p> <ul> <li> <p> <code>sprites.json</code> </p> </li> <li> <p> <code>sprites@2x.json</code> for high pixel density displays</p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"FileName\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The map resource associated with the sprite ï¬le.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        }\
      }\
    },\
    \"GetMapSpritesRequestFileNameString\":{\
      \"type\":\"string\",\
      \"pattern\":\"^sprites(@2x)?\\\\.(png|json)$\"\
    },\
    \"GetMapSpritesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Blob\":{\
          \"shape\":\"Blob\",\
          \"documentation\":\"<p>Contains the body of the sprite sheet or JSON offset ï¬le.</p>\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The HTTP Cache-Control directive for the value.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentType\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The content type of the sprite sheet and offsets. For example, the sprite sheet content type is <code>image/png</code>, and the sprite offset JSON document is <code>application/json</code>. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        }\
      },\
      \"payload\":\"Blob\"\
    },\
    \"GetMapStyleDescriptorRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"MapName\"],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The map resource to retrieve the style descriptor from.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        }\
      }\
    },\
    \"GetMapStyleDescriptorResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Blob\":{\
          \"shape\":\"Blob\",\
          \"documentation\":\"<p>Contains the body of the style descriptor.</p>\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The HTTP Cache-Control directive for the value.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentType\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The style descriptor's content type. For example, <code>application/json</code>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        }\
      },\
      \"payload\":\"Blob\"\
    },\
    \"GetMapTileRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"MapName\",\
        \"X\",\
        \"Y\",\
        \"Z\"\
      ],\
      \"members\":{\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The map resource to retrieve the map tiles from.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        },\
        \"X\":{\
          \"shape\":\"GetMapTileRequestXString\",\
          \"documentation\":\"<p>The X axis value for the map tile.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"X\"\
        },\
        \"Y\":{\
          \"shape\":\"GetMapTileRequestYString\",\
          \"documentation\":\"<p>The Y axis value for the map tile. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Y\"\
        },\
        \"Z\":{\
          \"shape\":\"GetMapTileRequestZString\",\
          \"documentation\":\"<p>The zoom value for the map tile.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"Z\"\
        }\
      }\
    },\
    \"GetMapTileRequestXString\":{\
      \"type\":\"string\",\
      \"pattern\":\"\\\\d+\"\
    },\
    \"GetMapTileRequestYString\":{\
      \"type\":\"string\",\
      \"pattern\":\"\\\\d+\"\
    },\
    \"GetMapTileRequestZString\":{\
      \"type\":\"string\",\
      \"pattern\":\"\\\\d+\"\
    },\
    \"GetMapTileResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Blob\":{\
          \"shape\":\"Blob\",\
          \"documentation\":\"<p>Contains Mapbox Vector Tile (MVT) data.</p>\"\
        },\
        \"CacheControl\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The HTTP Cache-Control directive for the value.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Cache-Control\"\
        },\
        \"ContentType\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The map tile's content type. For example, <code>application/vnd.mapbox-vector-tile</code>.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        }\
      },\
      \"payload\":\"Blob\"\
    },\
    \"GetPlaceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"PlaceId\"\
      ],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource that you want to use for the search.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. The value must be a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p> <p>This setting affects the languages used in the results, but not the results themselves. If no language is specified, or not supported for a particular result, the partner automatically chooses a language for the result.</p> <p>For an example, we'll use the Greek language. You search for a location around Athens, Greece, with the <code>language</code> parameter set to <code>en</code>. The <code>city</code> in the results will most likely be returned as <code>Athens</code>.</p> <p>If you set the <code>language</code> parameter to <code>el</code>, for Greek, then the <code>city</code> in the results will more likely be returned as <code>ÎÎ¸Î®Î½Î±</code>.</p> <p>If the data provider does not have a value for Greek, the result will be in a language that the provider does support.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"language\"\
        },\
        \"PlaceId\":{\
          \"shape\":\"PlaceId\",\
          \"documentation\":\"<p>The identifier of the place to find.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"PlaceId\"\
        }\
      }\
    },\
    \"GetPlaceResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Place\"],\
      \"members\":{\
        \"Place\":{\
          \"shape\":\"Place\",\
          \"documentation\":\"<p>Details about the result, such as its address and position.</p>\"\
        }\
      }\
    },\
    \"Id\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1,\
      \"pattern\":\"^[-._\\\\p{L}\\\\p{N}]+$\"\
    },\
    \"Integer\":{\
      \"type\":\"integer\",\
      \"box\":true\
    },\
    \"IntendedUse\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"SingleUse\",\
        \"Storage\"\
      ]\
    },\
    \"InternalServerException\":{\
      \"type\":\"structure\",\
      \"required\":[\"Message\"],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"locationName\":\"message\"\
        }\
      },\
      \"documentation\":\"<p>The request has failed to process because of an unknown server error, exception, or failure.</p>\",\
      \"error\":{\"httpStatusCode\":500},\
      \"exception\":true,\
      \"fault\":true,\
      \"retryable\":{\"throttling\":false}\
    },\
    \"KmsKeyId\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1\
    },\
    \"LanguageTag\":{\
      \"type\":\"string\",\
      \"max\":35,\
      \"min\":2\
    },\
    \"Leg\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Distance\",\
        \"DurationSeconds\",\
        \"EndPosition\",\
        \"StartPosition\",\
        \"Steps\"\
      ],\
      \"members\":{\
        \"Distance\":{\
          \"shape\":\"LegDistanceDouble\",\
          \"documentation\":\"<p>The distance between the leg's <code>StartPosition</code> and <code>EndPosition</code> along a calculated route. </p> <ul> <li> <p>The default measurement is <code>Kilometers</code> unless the request specifies a <code>DistanceUnit</code> of <code>Miles</code>.</p> </li> </ul>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"LegDurationSecondsDouble\",\
          \"documentation\":\"<p>The estimated travel time between the leg's <code>StartPosition</code> and <code>EndPosition</code>. The travel mode and departure time that you specify in the request determines the calculated time.</p>\"\
        },\
        \"EndPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The terminating position of the leg. Follows the format <code>[longitude,latitude]</code>.</p> <note> <p>If the <code>EndPosition</code> isn't located on a road, it's <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/nap-to-nearby-road.html\\\">snapped to a nearby road</a>. </p> </note>\"\
        },\
        \"Geometry\":{\
          \"shape\":\"LegGeometry\",\
          \"documentation\":\"<p>Contains the calculated route's path as a linestring geometry.</p>\"\
        },\
        \"StartPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The starting position of the leg. Follows the format <code>[longitude,latitude]</code>.</p> <note> <p>If the <code>StartPosition</code> isn't located on a road, it's <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\">snapped to a nearby road</a>. </p> </note>\"\
        },\
        \"Steps\":{\
          \"shape\":\"StepList\",\
          \"documentation\":\"<p>Contains a list of steps, which represent subsections of a leg. Each step provides instructions for how to move to the next step in the leg such as the step's start position, end position, travel distance, travel duration, and geometry offset.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the calculated route's details for each path between a pair of positions. The number of legs returned corresponds to one fewer than the total number of positions in the request. </p> <p>For example, a route with a departure position and destination position returns one leg with the positions <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/snap-to-nearby-road.html\\\">snapped to a nearby road</a>:</p> <ul> <li> <p>The <code>StartPosition</code> is the departure position.</p> </li> <li> <p>The <code>EndPosition</code> is the destination position.</p> </li> </ul> <p>A route with a waypoint between the departure and destination position returns two legs with the positions snapped to a nearby road:</p> <ul> <li> <p>Leg 1: The <code>StartPosition</code> is the departure position . The <code>EndPosition</code> is the waypoint positon.</p> </li> <li> <p>Leg 2: The <code>StartPosition</code> is the waypoint position. The <code>EndPosition</code> is the destination position.</p> </li> </ul>\"\
    },\
    \"LegDistanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"LegDurationSecondsDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"LegGeometry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"LineString\":{\
          \"shape\":\"LineString\",\
          \"documentation\":\"<p>An ordered list of positions used to plot a route on a map. </p> <p>The first position is closest to the start position for the leg, and the last position is the closest to the end position for the leg.</p> <ul> <li> <p>For example, <code>[[-123.117, 49.284],[-123.115, 49.285],[-123.115, 49.285]]</code> </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the geometry details for each path between a pair of positions. Used in plotting a route leg on a map.</p>\"\
    },\
    \"LegList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Leg\"}\
    },\
    \"LineString\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"min\":2\
    },\
    \"LinearRing\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Position\"},\
      \"min\":4\
    },\
    \"LinearRings\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"LinearRing\"},\
      \"min\":1\
    },\
    \"ListDevicePositionsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"TrackerName\"],\
      \"members\":{\
        \"FilterGeometry\":{\
          \"shape\":\"TrackingFilterGeometry\",\
          \"documentation\":\"<p>The geometry used to filter device positions.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"ListDevicePositionsRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of entries returned in a single call.</p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page.</p> <p>Default value: <code>null</code> </p>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The tracker resource containing the requested devices.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"ListDevicePositionsRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListDevicePositionsResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListDevicePositionsResponseEntryList\",\
          \"documentation\":\"<p>Contains details about each device's last known position.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results.</p>\"\
        }\
      }\
    },\
    \"ListDevicePositionsResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DeviceId\",\
        \"Position\",\
        \"SampleTime\"\
      ],\
      \"members\":{\
        \"Accuracy\":{\
          \"shape\":\"PositionalAccuracy\",\
          \"documentation\":\"<p>The accuracy of the device position.</p>\"\
        },\
        \"DeviceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The ID of the device for this position.</p>\"\
        },\
        \"Position\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The last known device position. Empty if no positions currently stored.</p>\"\
        },\
        \"PositionProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>The properties associated with the position.</p>\"\
        },\
        \"SampleTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp at which the device position was determined. Uses <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the tracker resource details.</p>\"\
    },\
    \"ListDevicePositionsResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListDevicePositionsResponseEntry\"}\
    },\
    \"ListGeofenceCollectionsRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MaxResults\":{\
          \"shape\":\"ListGeofenceCollectionsRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of resources returned in a single call. </p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page. </p> <p>Default value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListGeofenceCollectionsRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListGeofenceCollectionsResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListGeofenceCollectionsResponseEntryList\",\
          \"documentation\":\"<p>Lists the geofence collections that exist in your Amazon Web Services account.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results. </p>\"\
        }\
      }\
    },\
    \"ListGeofenceCollectionsResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionName\",\
        \"CreateTime\",\
        \"Description\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the geofence collection.</p>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence collection was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The description for the geofence collection</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>No longer used. Always returns an empty string.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Unused.\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Specifies a timestamp for when the resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the geofence collection details.</p>\"\
    },\
    \"ListGeofenceCollectionsResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListGeofenceCollectionsResponseEntry\"}\
    },\
    \"ListGeofenceResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"GeofenceId\",\
        \"Geometry\",\
        \"Status\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence was stored in a geofence collection in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence identifier.</p>\"\
        },\
        \"GeofenceProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>User defined properties of the geofence. A property is a key-value pair stored with the geofence and added to any geofence event triggered with that geofence.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p>\"\
        },\
        \"Geometry\":{\
          \"shape\":\"GeofenceGeometry\",\
          \"documentation\":\"<p>Contains the geofence geometry details describing a polygon or a circle.</p>\"\
        },\
        \"Status\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Identifies the state of the geofence. A geofence will hold one of the following states:</p> <ul> <li> <p> <code>ACTIVE</code> â The geofence has been indexed by the system. </p> </li> <li> <p> <code>PENDING</code> â The geofence is being processed by the system.</p> </li> <li> <p> <code>FAILED</code> â The geofence failed to be indexed by the system.</p> </li> <li> <p> <code>DELETED</code> â The geofence has been deleted from the system index.</p> </li> <li> <p> <code>DELETING</code> â The geofence is being deleted from the system index.</p> </li> </ul>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains a list of geofences stored in a given geofence collection.</p>\"\
    },\
    \"ListGeofenceResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListGeofenceResponseEntry\"}\
    },\
    \"ListGeofencesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CollectionName\"],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the geofence collection storing the list of geofences.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"ListGeofencesRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of geofences returned in a single call. </p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page. </p> <p>Default value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListGeofencesRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListGeofencesResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListGeofenceResponseEntryList\",\
          \"documentation\":\"<p>Contains a list of geofences stored in the geofence collection.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results. </p>\"\
        }\
      }\
    },\
    \"ListKeysRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Filter\":{\
          \"shape\":\"ApiKeyFilter\",\
          \"documentation\":\"<p>Optionally filter the list to only <code>Active</code> or <code>Expired</code> API keys.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"ListKeysRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of resources returned in a single call. </p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page. </p> <p>Default value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListKeysRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListKeysResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListKeysResponseEntryList\",\
          \"documentation\":\"<p>Contains API key resources in your Amazon Web Services account. Details include API key name, allowed referers and timestamp for when the API key will expire.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results. </p>\"\
        }\
      }\
    },\
    \"ListKeysResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"ExpireTime\",\
        \"KeyName\",\
        \"Restrictions\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp of when the API key was created, in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the API key resource.</p>\"\
        },\
        \"ExpireTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the API key resource will expire, in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key resource.</p>\"\
        },\
        \"Restrictions\":{\"shape\":\"ApiKeyRestrictions\"},\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp of when the API key was last updated, in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An API key resource listed in your Amazon Web Services account.</p>\"\
    },\
    \"ListKeysResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListKeysResponseEntry\"}\
    },\
    \"ListMapsRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MaxResults\":{\
          \"shape\":\"ListMapsRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of resources returned in a single call. </p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page.</p> <p>Default value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListMapsRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListMapsResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListMapsResponseEntryList\",\
          \"documentation\":\"<p>Contains a list of maps in your Amazon Web Services account</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results. </p>\"\
        }\
      }\
    },\
    \"ListMapsResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"DataSource\",\
        \"Description\",\
        \"MapName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the map resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Specifies the data provider for the associated map tiles.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The description for the map resource.</p>\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the associated map resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the map resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details of an existing map resource in your Amazon Web Services account.</p>\"\
    },\
    \"ListMapsResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListMapsResponseEntry\"}\
    },\
    \"ListPlaceIndexesRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MaxResults\":{\
          \"shape\":\"ListPlaceIndexesRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the maximum number of results returned in a single call.</p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page.</p> <p>Default value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListPlaceIndexesRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListPlaceIndexesResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListPlaceIndexesResponseEntryList\",\
          \"documentation\":\"<p>Lists the place index resources that exist in your Amazon Web Services account</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating that there are additional pages available. You can use the token in a new request to fetch the next page of results.</p>\"\
        }\
      }\
    },\
    \"ListPlaceIndexesResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"DataSource\",\
        \"Description\",\
        \"IndexName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the place index resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The data provider of geospatial data. Values can be one of the following:</p> <ul> <li> <p> <code>Esri</code> </p> </li> <li> <p> <code>Grab</code> </p> </li> <li> <p> <code>Here</code> </p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description for the place index resource.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the place index resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>A place index resource listed in your Amazon Web Services account.</p>\"\
    },\
    \"ListPlaceIndexesResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListPlaceIndexesResponseEntry\"}\
    },\
    \"ListRouteCalculatorsRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MaxResults\":{\
          \"shape\":\"ListRouteCalculatorsRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional maximum number of results returned in a single call.</p> <p>Default Value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page.</p> <p>Default Value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListRouteCalculatorsRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListRouteCalculatorsResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListRouteCalculatorsResponseEntryList\",\
          \"documentation\":\"<p>Lists the route calculator resources that exist in your Amazon Web Services account</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a subsequent request to fetch the next set of results.</p>\"\
        }\
      }\
    },\
    \"ListRouteCalculatorsResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorName\",\
        \"CreateTime\",\
        \"DataSource\",\
        \"Description\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource.</p>\"\
        },\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp when the route calculator resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p> <ul> <li> <p>For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The data provider of traffic and road network data. Indicates one of the available providers:</p> <ul> <li> <p> <code>Esri</code> </p> </li> <li> <p> <code>Grab</code> </p> </li> <li> <p> <code>Here</code> </p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The optional description of the route calculator resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp when the route calculator resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p> <ul> <li> <p>For example, <code>2020â07-2T12:15:20.000Z+01:00</code> </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>A route calculator resource listed in your Amazon Web Services account.</p>\"\
    },\
    \"ListRouteCalculatorsResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListRouteCalculatorsResponseEntry\"}\
    },\
    \"ListTagsForResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"ResourceArn\"],\
      \"members\":{\
        \"ResourceArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the resource whose tags you want to retrieve.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:resourcetype/ExampleResource</code> </p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"ResourceArn\"\
        }\
      }\
    },\
    \"ListTagsForResourceResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Tags that have been applied to the specified resource. Tags are mapped from the tag key to the tag value: <code>\\\"TagKey\\\" : \\\"TagValue\\\"</code>.</p> <ul> <li> <p>Format example: <code>{\\\"tag1\\\" : \\\"value1\\\", \\\"tag2\\\" : \\\"value2\\\"} </code> </p> </li> </ul>\"\
        }\
      }\
    },\
    \"ListTrackerConsumersRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"TrackerName\"],\
      \"members\":{\
        \"MaxResults\":{\
          \"shape\":\"ListTrackerConsumersRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of resources returned in a single call. </p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page. </p> <p>Default value: <code>null</code> </p>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The tracker resource whose associated geofence collections you want to list.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"ListTrackerConsumersRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListTrackerConsumersResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"ConsumerArns\"],\
      \"members\":{\
        \"ConsumerArns\":{\
          \"shape\":\"ArnList\",\
          \"documentation\":\"<p>Contains the list of geofence collection ARNs associated to the tracker resource.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results. </p>\"\
        }\
      }\
    },\
    \"ListTrackersRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MaxResults\":{\
          \"shape\":\"ListTrackersRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional limit for the number of resources returned in a single call. </p> <p>Default value: <code>100</code> </p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>The pagination token specifying which page of results to return in the response. If no token is provided, the default page is the first page. </p> <p>Default value: <code>null</code> </p>\"\
        }\
      }\
    },\
    \"ListTrackersRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":100,\
      \"min\":1\
    },\
    \"ListTrackersResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\"Entries\"],\
      \"members\":{\
        \"Entries\":{\
          \"shape\":\"ListTrackersResponseEntryList\",\
          \"documentation\":\"<p>Contains tracker resources in your Amazon Web Services account. Details include tracker name, description and timestamps for when the tracker was created and last updated.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"Token\",\
          \"documentation\":\"<p>A pagination token indicating there are additional pages available. You can use the token in a following request to fetch the next set of results. </p>\"\
        }\
      }\
    },\
    \"ListTrackersResponseEntry\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"Description\",\
        \"TrackerName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>The description for the tracker resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>Always returns <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Always returns RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>No longer used. Always returns an empty string.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. Unused.\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp at which the device's position was determined. Uses <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains the tracker resource details.</p>\"\
    },\
    \"ListTrackersResponseEntryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ListTrackersResponseEntry\"}\
    },\
    \"MapConfiguration\":{\
      \"type\":\"structure\",\
      \"required\":[\"Style\"],\
      \"members\":{\
        \"PoliticalView\":{\
          \"shape\":\"CountryCode3\",\
          \"documentation\":\"<p>Specifies the political view for the style. Leave unset to not use a political view, or, for styles that support specific political views, you can choose a view, such as <code>IND</code> for the Indian view.</p> <p>Default is unset.</p> <note> <p>Not all map resources or styles support political view styles. See <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/map-concepts.html#political-views\\\">Political views</a> for more information.</p> </note>\"\
        },\
        \"Style\":{\
          \"shape\":\"MapStyle\",\
          \"documentation\":\"<p>Specifies the map style selected from an available data provider.</p> <p>Valid <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/esri.html\\\">Esri map styles</a>:</p> <ul> <li> <p> <code>VectorEsriDarkGrayCanvas</code> â The Esri Dark Gray Canvas map style. A vector basemap with a dark gray, neutral background with minimal colors, labels, and features that's designed to draw attention to your thematic content. </p> </li> <li> <p> <code>RasterEsriImagery</code> â The Esri Imagery map style. A raster basemap that provides one meter or better satellite and aerial imagery in many parts of the world and lower resolution satellite imagery worldwide. </p> </li> <li> <p> <code>VectorEsriLightGrayCanvas</code> â The Esri Light Gray Canvas map style, which provides a detailed vector basemap with a light gray, neutral background style with minimal colors, labels, and features that's designed to draw attention to your thematic content. </p> </li> <li> <p> <code>VectorEsriTopographic</code> â The Esri Light map style, which provides a detailed vector basemap with a classic Esri map style.</p> </li> <li> <p> <code>VectorEsriStreets</code> â The Esri Street Map style, which provides a detailed vector basemap for the world symbolized with a classic Esri street map style. The vector tile layer is similar in content and style to the World Street Map raster map.</p> </li> <li> <p> <code>VectorEsriNavigation</code> â The Esri Navigation map style, which provides a detailed basemap for the world symbolized with a custom navigation map style that's designed for use during the day in mobile devices.</p> </li> </ul> <p>Valid <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/HERE.html\\\">HERE Technologies map styles</a>:</p> <ul> <li> <p> <code>VectorHereContrast</code> â The HERE Contrast (Berlin) map style is a high contrast detailed base map of the world that blends 3D and 2D rendering.</p> <note> <p>The <code>VectorHereContrast</code> style has been renamed from <code>VectorHereBerlin</code>. <code>VectorHereBerlin</code> has been deprecated, but will continue to work in applications that use it.</p> </note> </li> <li> <p> <code>VectorHereExplore</code> â A default HERE map style containing a neutral, global map and its features including roads, buildings, landmarks, and water features. It also now includes a fully designed map of Japan.</p> </li> <li> <p> <code>VectorHereExploreTruck</code> â A global map containing truck restrictions and attributes (e.g. width / height / HAZMAT) symbolized with highlighted segments and icons on top of HERE Explore to support use cases within transport and logistics.</p> </li> <li> <p> <code>RasterHereExploreSatellite</code> â A global map containing high resolution satellite imagery.</p> </li> <li> <p> <code>HybridHereExploreSatellite</code> â A global map displaying the road network, street names, and city labels over satellite imagery. This style will automatically retrieve both raster and vector tiles, and your charges will be based on total tiles retrieved.</p> <note> <p>Hybrid styles use both vector and raster tiles when rendering the map that you see. This means that more tiles are retrieved than when using either vector or raster tiles alone. Your charges will include all tiles retrieved.</p> </note> </li> </ul> <p>Valid <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html\\\">GrabMaps map styles</a>:</p> <ul> <li> <p> <code>VectorGrabStandardLight</code> â The Grab Standard Light map style provides a basemap with detailed land use coloring, area names, roads, landmarks, and points of interest covering Southeast Asia.</p> </li> <li> <p> <code>VectorGrabStandardDark</code> â The Grab Standard Dark map style provides a dark variation of the standard basemap covering Southeast Asia.</p> </li> </ul> <note> <p>Grab provides maps only for countries in Southeast Asia, and is only available in the Asia Pacific (Singapore) Region (<code>ap-southeast-1</code>). For more information, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/grab.html#grab-coverage-area\\\">GrabMaps countries and area covered</a>.</p> </note> <p>Valid <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/open-data.html\\\">Open Data map styles</a>:</p> <ul> <li> <p> <code>VectorOpenDataStandardLight</code> â The Open Data Standard Light map style provides a detailed basemap for the world suitable for website and mobile application use. The map includes highways major roads, minor roads, railways, water features, cities, parks, landmarks, building footprints, and administrative boundaries.</p> </li> <li> <p> <code>VectorOpenDataStandardDark</code> â Open Data Standard Dark is a dark-themed map style that provides a detailed basemap for the world suitable for website and mobile application use. The map includes highways major roads, minor roads, railways, water features, cities, parks, landmarks, building footprints, and administrative boundaries.</p> </li> <li> <p> <code>VectorOpenDataVisualizationLight</code> â The Open Data Visualization Light map style is a light-themed style with muted colors and fewer features that aids in understanding overlaid data.</p> </li> <li> <p> <code>VectorOpenDataVisualizationDark</code> â The Open Data Visualization Dark map style is a dark-themed style with muted colors and fewer features that aids in understanding overlaid data.</p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the map tile style selected from an available provider.</p>\"\
    },\
    \"MapConfigurationUpdate\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PoliticalView\":{\
          \"shape\":\"CountryCode3OrEmpty\",\
          \"documentation\":\"<p>Specifies the political view for the style. Set to an empty string to not use a political view, or, for styles that support specific political views, you can choose a view, such as <code>IND</code> for the Indian view.</p> <note> <p>Not all map resources or styles support political view styles. See <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/map-concepts.html#political-views\\\">Political views</a> for more information.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Specifies the political view for the style.</p>\"\
    },\
    \"MapStyle\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1,\
      \"pattern\":\"^[-._\\\\w]+$\"\
    },\
    \"OptimizationMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"FastestRoute\",\
        \"ShortestRoute\"\
      ]\
    },\
    \"Place\":{\
      \"type\":\"structure\",\
      \"required\":[\"Geometry\"],\
      \"members\":{\
        \"AddressNumber\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The numerical portion of an address, such as a building number. </p>\"\
        },\
        \"Categories\":{\
          \"shape\":\"PlaceCategoryList\",\
          \"documentation\":\"<p>The Amazon Location categories that describe this Place.</p> <p>For more information about using categories, including a list of Amazon Location categories, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/category-filtering.html\\\">Categories and filtering</a>, in the <i>Amazon Location Service Developer Guide</i>.</p>\"\
        },\
        \"Country\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A country/region specified using <a href=\\\"https://www.iso.org/iso-3166-country-codes.html\\\">ISO 3166</a> 3-digit country/region code. For example, <code>CAN</code>.</p>\"\
        },\
        \"Geometry\":{\"shape\":\"PlaceGeometry\"},\
        \"Interpolated\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p> <code>True</code> if the result is interpolated from other known places.</p> <p> <code>False</code> if the Place is a known place.</p> <p>Not returned when the partner does not provide the information.</p> <p>For example, returns <code>False</code> for an address location that is found in the partner data, but returns <code>True</code> if an address does not exist in the partner data and its location is calculated by interpolating between other known addresses. </p>\"\
        },\
        \"Label\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The full name and address of the point of interest such as a city, region, or country. For example, <code>123 Any Street, Any Town, USA</code>.</p>\"\
        },\
        \"Municipality\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A name for a local area, such as a city or town name. For example, <code>Toronto</code>.</p>\"\
        },\
        \"Neighborhood\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The name of a community district. For example, <code>Downtown</code>.</p>\"\
        },\
        \"PostalCode\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A group of numbers and letters in a country-specific format, which accompanies the address for the purpose of identifying a location. </p>\"\
        },\
        \"Region\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A name for an area or geographical division, such as a province or state name. For example, <code>British Columbia</code>.</p>\"\
        },\
        \"Street\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The name for a street or a road to identify a location. For example, <code>Main Street</code>.</p>\"\
        },\
        \"SubMunicipality\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>An area that's part of a larger municipality. For example, <code>Blissville </code> is a submunicipality in the Queen County in New York.</p> <note> <p>This property supported by Esri and OpenData. The Esri property is <code>district</code>, and the OpenData property is <code>borough</code>.</p> </note>\"\
        },\
        \"SubRegion\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A county, or an area that's part of a larger region. For example, <code>Metro Vancouver</code>.</p>\"\
        },\
        \"SupplementalCategories\":{\
          \"shape\":\"PlaceSupplementalCategoryList\",\
          \"documentation\":\"<p>Categories from the data provider that describe the Place that are not mapped to any Amazon Location categories.</p>\"\
        },\
        \"TimeZone\":{\
          \"shape\":\"TimeZone\",\
          \"documentation\":\"<p>The time zone in which the <code>Place</code> is located. Returned only when using HERE or Grab as the selected partner.</p>\"\
        },\
        \"UnitNumber\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>For addresses with multiple units, the unit identifier. Can include numbers and letters, for example <code>3B</code> or <code>Unit 123</code>.</p> <note> <p>Returned only for a place index that uses Esri or Grab as a data provider. Is not returned for <code>SearchPlaceIndexForPosition</code>.</p> </note>\"\
        },\
        \"UnitType\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>For addresses with a <code>UnitNumber</code>, the type of unit. For example, <code>Apartment</code>.</p> <note> <p>Returned only for a place index that uses Esri as a data provider.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details about addresses or points of interest that match the search criteria.</p> <p>Not all details are included with all responses. Some details may only be returned by specific data partners.</p>\"\
    },\
    \"PlaceCategory\":{\
      \"type\":\"string\",\
      \"max\":35,\
      \"min\":0\
    },\
    \"PlaceCategoryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PlaceCategory\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"PlaceGeometry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Point\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>A single point geometry specifies a location for a Place using <a href=\\\"https://gisgeography.com/wgs84-world-geodetic-system/\\\">WGS 84</a> coordinates:</p> <ul> <li> <p> <i>x</i> â Specifies the x coordinate or longitude. </p> </li> <li> <p> <i>y</i> â Specifies the y coordinate or latitude. </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Places uses a point geometry to specify a location or a Place.</p>\"\
    },\
    \"PlaceId\":{\"type\":\"string\"},\
    \"PlaceIndexSearchResultLimit\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":50,\
      \"min\":1\
    },\
    \"PlaceSupplementalCategory\":{\
      \"type\":\"string\",\
      \"max\":35,\
      \"min\":0\
    },\
    \"PlaceSupplementalCategoryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PlaceSupplementalCategory\"},\
      \"max\":10,\
      \"min\":1\
    },\
    \"Position\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Double\"},\
      \"max\":2,\
      \"min\":2,\
      \"sensitive\":true\
    },\
    \"PositionFiltering\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"TimeBased\",\
        \"DistanceBased\",\
        \"AccuracyBased\"\
      ]\
    },\
    \"PositionalAccuracy\":{\
      \"type\":\"structure\",\
      \"required\":[\"Horizontal\"],\
      \"members\":{\
        \"Horizontal\":{\
          \"shape\":\"PositionalAccuracyHorizontalDouble\",\
          \"documentation\":\"<p>Estimated maximum distance, in meters, between the measured position and the true position of a device, along the Earth's surface.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Defines the level of certainty of the position.</p>\"\
    },\
    \"PositionalAccuracyHorizontalDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"max\":10000,\
      \"min\":0\
    },\
    \"PricingPlan\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RequestBasedUsage\",\
        \"MobileAssetTracking\",\
        \"MobileAssetManagement\"\
      ]\
    },\
    \"PropertyMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"PropertyMapKeyString\"},\
      \"value\":{\"shape\":\"PropertyMapValueString\"},\
      \"max\":3,\
      \"min\":0,\
      \"sensitive\":true\
    },\
    \"PropertyMapKeyString\":{\
      \"type\":\"string\",\
      \"max\":20,\
      \"min\":1\
    },\
    \"PropertyMapValueString\":{\
      \"type\":\"string\",\
      \"max\":40,\
      \"min\":1\
    },\
    \"PutGeofenceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionName\",\
        \"GeofenceId\",\
        \"Geometry\"\
      ],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The geofence collection to store the geofence in.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>An identifier for the geofence. For example, <code>ExampleGeofence-1</code>.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"GeofenceId\"\
        },\
        \"GeofenceProperties\":{\
          \"shape\":\"PropertyMap\",\
          \"documentation\":\"<p>Associates one of more properties with the geofence. A property is a key-value pair stored with the geofence and added to any geofence event triggered with that geofence.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p>\"\
        },\
        \"Geometry\":{\
          \"shape\":\"GeofenceGeometry\",\
          \"documentation\":\"<p>Contains the details to specify the position of the geofence. Can be either a polygon or a circle. Including both will return a validation error.</p> <note> <p>Each <a href=\\\"https://docs.aws.amazon.com/location-geofences/latest/APIReference/API_GeofenceGeometry.html\\\"> geofence polygon</a> can have a maximum of 1,000 vertices.</p> </note>\"\
        }\
      }\
    },\
    \"PutGeofenceResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CreateTime\",\
        \"GeofenceId\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CreateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence was created in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        },\
        \"GeofenceId\":{\
          \"shape\":\"Id\",\
          \"documentation\":\"<p>The geofence identifier entered in the request.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the geofence was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      }\
    },\
    \"RefererPattern\":{\
      \"type\":\"string\",\
      \"max\":253,\
      \"min\":0,\
      \"pattern\":\"^([$\\\\-._+!*\\\\x{60}(),;/?:@=&\\\\w]|%([0-9a-fA-F?]{2}|[0-9a-fA-F?]?[*]))+$\"\
    },\
    \"ResourceDescription\":{\
      \"type\":\"string\",\
      \"max\":1000,\
      \"min\":0\
    },\
    \"ResourceName\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1,\
      \"pattern\":\"^[-._\\\\w]+$\"\
    },\
    \"ResourceNotFoundException\":{\
      \"type\":\"structure\",\
      \"required\":[\"Message\"],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"locationName\":\"message\"\
        }\
      },\
      \"documentation\":\"<p>The resource that you've entered was not found in your AWS account.</p>\",\
      \"error\":{\
        \"httpStatusCode\":404,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"RouteMatrix\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"RouteMatrixRow\"}\
    },\
    \"RouteMatrixEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Distance\":{\
          \"shape\":\"RouteMatrixEntryDistanceDouble\",\
          \"documentation\":\"<p>The total distance of travel for the route.</p>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"RouteMatrixEntryDurationSecondsDouble\",\
          \"documentation\":\"<p>The expected duration of travel for the route.</p>\"\
        },\
        \"Error\":{\
          \"shape\":\"RouteMatrixEntryError\",\
          \"documentation\":\"<p>An error corresponding to the calculation of a route between the <code>DeparturePosition</code> and <code>DestinationPosition</code>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The result for the calculated route of one <code>DeparturePosition</code> <code>DestinationPosition</code> pair.</p>\"\
    },\
    \"RouteMatrixEntryDistanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"RouteMatrixEntryDurationSecondsDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"RouteMatrixEntryError\":{\
      \"type\":\"structure\",\
      \"required\":[\"Code\"],\
      \"members\":{\
        \"Code\":{\
          \"shape\":\"RouteMatrixErrorCode\",\
          \"documentation\":\"<p>The type of error which occurred for the route calculation.</p>\"\
        },\
        \"Message\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A message about the error that occurred for the route calculation.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An error corresponding to the calculation of a route between the <code>DeparturePosition</code> and <code>DestinationPosition</code>.</p> <p>The error code can be one of the following:</p> <ul> <li> <p> <code>RouteNotFound</code> - Unable to find a valid route with the given parameters.</p> </li> </ul> <ul> <li> <p> <code>RouteTooLong</code> - Route calculation went beyond the maximum size of a route and was terminated before completion.</p> </li> </ul> <ul> <li> <p> <code>PositionsNotFound</code> - One or more of the input positions were not found on the route network.</p> </li> </ul> <ul> <li> <p> <code>DestinationPositionNotFound</code> - The destination position was not found on the route network.</p> </li> </ul> <ul> <li> <p> <code>DeparturePositionNotFound</code> - The departure position was not found on the route network.</p> </li> </ul> <ul> <li> <p> <code>OtherValidationError</code> - The given inputs were not valid or a route was not found. More information is given in the error <code>Message</code> </p> </li> </ul>\"\
    },\
    \"RouteMatrixErrorCode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RouteNotFound\",\
        \"RouteTooLong\",\
        \"PositionsNotFound\",\
        \"DestinationPositionNotFound\",\
        \"DeparturePositionNotFound\",\
        \"OtherValidationError\"\
      ]\
    },\
    \"RouteMatrixRow\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"RouteMatrixEntry\"}\
    },\
    \"SearchForPositionResult\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Distance\",\
        \"Place\"\
      ],\
      \"members\":{\
        \"Distance\":{\
          \"shape\":\"SearchForPositionResultDistanceDouble\",\
          \"documentation\":\"<p>The distance in meters of a great-circle arc between the query position and the result.</p> <note> <p>A great-circle arc is the shortest path on a sphere, in this case the Earth. This returns the shortest distance between two locations.</p> </note>\"\
        },\
        \"Place\":{\
          \"shape\":\"Place\",\
          \"documentation\":\"<p>Details about the search result, such as its address and position.</p>\"\
        },\
        \"PlaceId\":{\
          \"shape\":\"PlaceId\",\
          \"documentation\":\"<p>The unique identifier of the place. You can use this with the <code>GetPlace</code> operation to find the place again later.</p> <note> <p>For <code>SearchPlaceIndexForPosition</code> operations, the <code>PlaceId</code> is returned only by place indexes that use HERE or Grab as a data provider.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Contains a search result from a position search query that is run on a place index resource.</p>\"\
    },\
    \"SearchForPositionResultDistanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"SearchForPositionResultList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"SearchForPositionResult\"}\
    },\
    \"SearchForSuggestionsResult\":{\
      \"type\":\"structure\",\
      \"required\":[\"Text\"],\
      \"members\":{\
        \"Categories\":{\
          \"shape\":\"PlaceCategoryList\",\
          \"documentation\":\"<p>The Amazon Location categories that describe the Place.</p> <p>For more information about using categories, including a list of Amazon Location categories, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/category-filtering.html\\\">Categories and filtering</a>, in the <i>Amazon Location Service Developer Guide</i>.</p>\"\
        },\
        \"PlaceId\":{\
          \"shape\":\"PlaceId\",\
          \"documentation\":\"<p>The unique identifier of the Place. You can use this with the <code>GetPlace</code> operation to find the place again later, or to get full information for the Place.</p> <p>The <code>GetPlace</code> request must use the same <code>PlaceIndex</code> resource as the <code>SearchPlaceIndexForSuggestions</code> that generated the Place ID.</p> <note> <p>For <code>SearchPlaceIndexForSuggestions</code> operations, the <code>PlaceId</code> is returned by place indexes that use Esri, Grab, or HERE as data providers.</p> </note>\"\
        },\
        \"SupplementalCategories\":{\
          \"shape\":\"PlaceSupplementalCategoryList\",\
          \"documentation\":\"<p>Categories from the data provider that describe the Place that are not mapped to any Amazon Location categories.</p>\"\
        },\
        \"Text\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The text of the place suggestion, typically formatted as an address string.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains a place suggestion resulting from a place suggestion query that is run on a place index resource.</p>\"\
    },\
    \"SearchForSuggestionsResultList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"SearchForSuggestionsResult\"}\
    },\
    \"SearchForTextResult\":{\
      \"type\":\"structure\",\
      \"required\":[\"Place\"],\
      \"members\":{\
        \"Distance\":{\
          \"shape\":\"SearchForTextResultDistanceDouble\",\
          \"documentation\":\"<p>The distance in meters of a great-circle arc between the bias position specified and the result. <code>Distance</code> will be returned only if a bias position was specified in the query.</p> <note> <p>A great-circle arc is the shortest path on a sphere, in this case the Earth. This returns the shortest distance between two locations.</p> </note>\"\
        },\
        \"Place\":{\
          \"shape\":\"Place\",\
          \"documentation\":\"<p>Details about the search result, such as its address and position.</p>\"\
        },\
        \"PlaceId\":{\
          \"shape\":\"PlaceId\",\
          \"documentation\":\"<p>The unique identifier of the place. You can use this with the <code>GetPlace</code> operation to find the place again later.</p> <note> <p>For <code>SearchPlaceIndexForText</code> operations, the <code>PlaceId</code> is returned only by place indexes that use HERE or Grab as a data provider.</p> </note>\"\
        },\
        \"Relevance\":{\
          \"shape\":\"SearchForTextResultRelevanceDouble\",\
          \"documentation\":\"<p>The relative confidence in the match for a result among the results returned. For example, if more fields for an address match (including house number, street, city, country/region, and postal code), the relevance score is closer to 1.</p> <p>Returned only when the partner selected is Esri or Grab.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains a search result from a text search query that is run on a place index resource.</p>\"\
    },\
    \"SearchForTextResultDistanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"SearchForTextResultList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"SearchForTextResult\"}\
    },\
    \"SearchForTextResultRelevanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"max\":1,\
      \"min\":0\
    },\
    \"SearchPlaceIndexForPositionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"Position\"\
      ],\
      \"members\":{\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource you want to use for the search.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. The value must be a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p> <p>This setting affects the languages used in the results, but not the results themselves. If no language is specified, or not supported for a particular result, the partner automatically chooses a language for the result.</p> <p>For an example, we'll use the Greek language. You search for a location around Athens, Greece, with the <code>language</code> parameter set to <code>en</code>. The <code>city</code> in the results will most likely be returned as <code>Athens</code>.</p> <p>If you set the <code>language</code> parameter to <code>el</code>, for Greek, then the <code>city</code> in the results will more likely be returned as <code>ÎÎ¸Î®Î½Î±</code>.</p> <p>If the data provider does not have a value for Greek, the result will be in a language that the provider does support.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"PlaceIndexSearchResultLimit\",\
          \"documentation\":\"<p>An optional parameter. The maximum number of results returned per request.</p> <p>Default value: <code>50</code> </p>\"\
        },\
        \"Position\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>Specifies the longitude and latitude of the position to query.</p> <p> This parameter must contain a pair of numbers. The first number represents the X coordinate, or longitude; the second number represents the Y coordinate, or latitude.</p> <p>For example, <code>[-123.1174, 49.2847]</code> represents a position with longitude <code>-123.1174</code> and latitude <code>49.2847</code>.</p>\"\
        }\
      }\
    },\
    \"SearchPlaceIndexForPositionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Results\",\
        \"Summary\"\
      ],\
      \"members\":{\
        \"Results\":{\
          \"shape\":\"SearchForPositionResultList\",\
          \"documentation\":\"<p>Returns a list of Places closest to the specified position. Each result contains additional information about the Places returned.</p>\"\
        },\
        \"Summary\":{\
          \"shape\":\"SearchPlaceIndexForPositionSummary\",\
          \"documentation\":\"<p>Contains a summary of the request. Echoes the input values for <code>Position</code>, <code>Language</code>, <code>MaxResults</code>, and the <code>DataSource</code> of the place index. </p>\"\
        }\
      }\
    },\
    \"SearchPlaceIndexForPositionSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DataSource\",\
        \"Position\"\
      ],\
      \"members\":{\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The geospatial data provider attached to the place index resource specified in the request. Values can be one of the following:</p> <ul> <li> <p>Esri</p> </li> <li> <p>Grab</p> </li> <li> <p>Here</p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. Matches the language in the request. The value is a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"PlaceIndexSearchResultLimit\",\
          \"documentation\":\"<p>Contains the optional result count limit that is specified in the request.</p> <p>Default value: <code>50</code> </p>\"\
        },\
        \"Position\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The position specified in the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A summary of the request sent by using <code>SearchPlaceIndexForPosition</code>.</p>\"\
    },\
    \"SearchPlaceIndexForSuggestionsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"Text\"\
      ],\
      \"members\":{\
        \"BiasPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>An optional parameter that indicates a preference for place suggestions that are closer to a specified position.</p> <p> If provided, this parameter must contain a pair of numbers. The first number represents the X coordinate, or longitude; the second number represents the Y coordinate, or latitude.</p> <p>For example, <code>[-123.1174, 49.2847]</code> represents the position with longitude <code>-123.1174</code> and latitude <code>49.2847</code>.</p> <note> <p> <code>BiasPosition</code> and <code>FilterBBox</code> are mutually exclusive. Specifying both options results in an error. </p> </note>\"\
        },\
        \"FilterBBox\":{\
          \"shape\":\"BoundingBox\",\
          \"documentation\":\"<p>An optional parameter that limits the search results by returning only suggestions within a specified bounding box.</p> <p> If provided, this parameter must contain a total of four consecutive numbers in two pairs. The first pair of numbers represents the X and Y coordinates (longitude and latitude, respectively) of the southwest corner of the bounding box; the second pair of numbers represents the X and Y coordinates (longitude and latitude, respectively) of the northeast corner of the bounding box.</p> <p>For example, <code>[-12.7935, -37.4835, -12.0684, -36.9542]</code> represents a bounding box where the southwest corner has longitude <code>-12.7935</code> and latitude <code>-37.4835</code>, and the northeast corner has longitude <code>-12.0684</code> and latitude <code>-36.9542</code>.</p> <note> <p> <code>FilterBBox</code> and <code>BiasPosition</code> are mutually exclusive. Specifying both options results in an error. </p> </note>\"\
        },\
        \"FilterCategories\":{\
          \"shape\":\"FilterPlaceCategoryList\",\
          \"documentation\":\"<p>A list of one or more Amazon Location categories to filter the returned places. If you include more than one category, the results will include results that match <i>any</i> of the categories listed.</p> <p>For more information about using categories, including a list of Amazon Location categories, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/category-filtering.html\\\">Categories and filtering</a>, in the <i>Amazon Location Service Developer Guide</i>.</p>\"\
        },\
        \"FilterCountries\":{\
          \"shape\":\"CountryCodeList\",\
          \"documentation\":\"<p>An optional parameter that limits the search results by returning only suggestions within the provided list of countries.</p> <ul> <li> <p>Use the <a href=\\\"https://www.iso.org/iso-3166-country-codes.html\\\">ISO 3166</a> 3-digit country code. For example, Australia uses three upper-case characters: <code>AUS</code>.</p> </li> </ul>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource you want to use for the search.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. The value must be a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p> <p>This setting affects the languages used in the results. If no language is specified, or not supported for a particular result, the partner automatically chooses a language for the result.</p> <p>For an example, we'll use the Greek language. You search for <code>Athens, Gr</code> to get suggestions with the <code>language</code> parameter set to <code>en</code>. The results found will most likely be returned as <code>Athens, Greece</code>.</p> <p>If you set the <code>language</code> parameter to <code>el</code>, for Greek, then the result found will more likely be returned as <code>ÎÎ¸Î®Î½Î±, ÎÎ»Î»Î¬Î´Î±</code>.</p> <p>If the data provider does not have a value for Greek, the result will be in a language that the provider does support.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"SearchPlaceIndexForSuggestionsRequestMaxResultsInteger\",\
          \"documentation\":\"<p>An optional parameter. The maximum number of results returned per request. </p> <p>The default: <code>5</code> </p>\"\
        },\
        \"Text\":{\
          \"shape\":\"SearchPlaceIndexForSuggestionsRequestTextString\",\
          \"documentation\":\"<p>The free-form partial text to use to generate place suggestions. For example, <code>eiffel tow</code>.</p>\"\
        }\
      }\
    },\
    \"SearchPlaceIndexForSuggestionsRequestMaxResultsInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"max\":15,\
      \"min\":1\
    },\
    \"SearchPlaceIndexForSuggestionsRequestTextString\":{\
      \"type\":\"string\",\
      \"max\":200,\
      \"min\":1,\
      \"sensitive\":true\
    },\
    \"SearchPlaceIndexForSuggestionsResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Results\",\
        \"Summary\"\
      ],\
      \"members\":{\
        \"Results\":{\
          \"shape\":\"SearchForSuggestionsResultList\",\
          \"documentation\":\"<p>A list of place suggestions that best match the search text.</p>\"\
        },\
        \"Summary\":{\
          \"shape\":\"SearchPlaceIndexForSuggestionsSummary\",\
          \"documentation\":\"<p>Contains a summary of the request. Echoes the input values for <code>BiasPosition</code>, <code>FilterBBox</code>, <code>FilterCountries</code>, <code>Language</code>, <code>MaxResults</code>, and <code>Text</code>. Also includes the <code>DataSource</code> of the place index. </p>\"\
        }\
      }\
    },\
    \"SearchPlaceIndexForSuggestionsSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DataSource\",\
        \"Text\"\
      ],\
      \"members\":{\
        \"BiasPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>Contains the coordinates for the optional bias position specified in the request.</p> <p>This parameter contains a pair of numbers. The first number represents the X coordinate, or longitude; the second number represents the Y coordinate, or latitude.</p> <p>For example, <code>[-123.1174, 49.2847]</code> represents the position with longitude <code>-123.1174</code> and latitude <code>49.2847</code>.</p>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The geospatial data provider attached to the place index resource specified in the request. Values can be one of the following:</p> <ul> <li> <p>Esri</p> </li> <li> <p>Grab</p> </li> <li> <p>Here</p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"FilterBBox\":{\
          \"shape\":\"BoundingBox\",\
          \"documentation\":\"<p>Contains the coordinates for the optional bounding box specified in the request.</p>\"\
        },\
        \"FilterCategories\":{\
          \"shape\":\"FilterPlaceCategoryList\",\
          \"documentation\":\"<p>The optional category filter specified in the request.</p>\"\
        },\
        \"FilterCountries\":{\
          \"shape\":\"CountryCodeList\",\
          \"documentation\":\"<p>Contains the optional country filter specified in the request.</p>\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. Matches the language in the request. The value is a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>Contains the optional result count limit specified in the request.</p>\"\
        },\
        \"Text\":{\
          \"shape\":\"SensitiveString\",\
          \"documentation\":\"<p>The free-form partial text input specified in the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A summary of the request sent by using <code>SearchPlaceIndexForSuggestions</code>.</p>\"\
    },\
    \"SearchPlaceIndexForTextRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexName\",\
        \"Text\"\
      ],\
      \"members\":{\
        \"BiasPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>An optional parameter that indicates a preference for places that are closer to a specified position.</p> <p> If provided, this parameter must contain a pair of numbers. The first number represents the X coordinate, or longitude; the second number represents the Y coordinate, or latitude.</p> <p>For example, <code>[-123.1174, 49.2847]</code> represents the position with longitude <code>-123.1174</code> and latitude <code>49.2847</code>.</p> <note> <p> <code>BiasPosition</code> and <code>FilterBBox</code> are mutually exclusive. Specifying both options results in an error. </p> </note>\"\
        },\
        \"FilterBBox\":{\
          \"shape\":\"BoundingBox\",\
          \"documentation\":\"<p>An optional parameter that limits the search results by returning only places that are within the provided bounding box.</p> <p> If provided, this parameter must contain a total of four consecutive numbers in two pairs. The first pair of numbers represents the X and Y coordinates (longitude and latitude, respectively) of the southwest corner of the bounding box; the second pair of numbers represents the X and Y coordinates (longitude and latitude, respectively) of the northeast corner of the bounding box.</p> <p>For example, <code>[-12.7935, -37.4835, -12.0684, -36.9542]</code> represents a bounding box where the southwest corner has longitude <code>-12.7935</code> and latitude <code>-37.4835</code>, and the northeast corner has longitude <code>-12.0684</code> and latitude <code>-36.9542</code>.</p> <note> <p> <code>FilterBBox</code> and <code>BiasPosition</code> are mutually exclusive. Specifying both options results in an error. </p> </note>\"\
        },\
        \"FilterCategories\":{\
          \"shape\":\"FilterPlaceCategoryList\",\
          \"documentation\":\"<p>A list of one or more Amazon Location categories to filter the returned places. If you include more than one category, the results will include results that match <i>any</i> of the categories listed.</p> <p>For more information about using categories, including a list of Amazon Location categories, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/category-filtering.html\\\">Categories and filtering</a>, in the <i>Amazon Location Service Developer Guide</i>.</p>\"\
        },\
        \"FilterCountries\":{\
          \"shape\":\"CountryCodeList\",\
          \"documentation\":\"<p>An optional parameter that limits the search results by returning only places that are in a specified list of countries.</p> <ul> <li> <p>Valid values include <a href=\\\"https://www.iso.org/iso-3166-country-codes.html\\\">ISO 3166</a> 3-digit country codes. For example, Australia uses three upper-case characters: <code>AUS</code>.</p> </li> </ul>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource you want to use for the search.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        },\
        \"Key\":{\
          \"shape\":\"ApiKey\",\
          \"documentation\":\"<p>The optional <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/using-apikeys.html\\\">API key</a> to authorize the request.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"key\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. The value must be a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p> <p>This setting affects the languages used in the results, but not the results themselves. If no language is specified, or not supported for a particular result, the partner automatically chooses a language for the result.</p> <p>For an example, we'll use the Greek language. You search for <code>Athens, Greece</code>, with the <code>language</code> parameter set to <code>en</code>. The result found will most likely be returned as <code>Athens</code>.</p> <p>If you set the <code>language</code> parameter to <code>el</code>, for Greek, then the result found will more likely be returned as <code>ÎÎ¸Î®Î½Î±</code>.</p> <p>If the data provider does not have a value for Greek, the result will be in a language that the provider does support.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"PlaceIndexSearchResultLimit\",\
          \"documentation\":\"<p>An optional parameter. The maximum number of results returned per request. </p> <p>The default: <code>50</code> </p>\"\
        },\
        \"Text\":{\
          \"shape\":\"SearchPlaceIndexForTextRequestTextString\",\
          \"documentation\":\"<p>The address, name, city, or region to be used in the search in free-form text format. For example, <code>123 Any Street</code>.</p>\"\
        }\
      }\
    },\
    \"SearchPlaceIndexForTextRequestTextString\":{\
      \"type\":\"string\",\
      \"max\":200,\
      \"min\":1,\
      \"sensitive\":true\
    },\
    \"SearchPlaceIndexForTextResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Results\",\
        \"Summary\"\
      ],\
      \"members\":{\
        \"Results\":{\
          \"shape\":\"SearchForTextResultList\",\
          \"documentation\":\"<p>A list of Places matching the input text. Each result contains additional information about the specific point of interest. </p> <p>Not all response properties are included with all responses. Some properties may only be returned by specific data partners.</p>\"\
        },\
        \"Summary\":{\
          \"shape\":\"SearchPlaceIndexForTextSummary\",\
          \"documentation\":\"<p>Contains a summary of the request. Echoes the input values for <code>BiasPosition</code>, <code>FilterBBox</code>, <code>FilterCountries</code>, <code>Language</code>, <code>MaxResults</code>, and <code>Text</code>. Also includes the <code>DataSource</code> of the place index and the bounding box, <code>ResultBBox</code>, which surrounds the search results. </p>\"\
        }\
      }\
    },\
    \"SearchPlaceIndexForTextSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"DataSource\",\
        \"Text\"\
      ],\
      \"members\":{\
        \"BiasPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>Contains the coordinates for the optional bias position specified in the request.</p> <p>This parameter contains a pair of numbers. The first number represents the X coordinate, or longitude; the second number represents the Y coordinate, or latitude.</p> <p>For example, <code>[-123.1174, 49.2847]</code> represents the position with longitude <code>-123.1174</code> and latitude <code>49.2847</code>.</p>\"\
        },\
        \"DataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The geospatial data provider attached to the place index resource specified in the request. Values can be one of the following:</p> <ul> <li> <p>Esri</p> </li> <li> <p>Grab</p> </li> <li> <p>Here</p> </li> </ul> <p>For more information about data providers, see <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html\\\">Amazon Location Service data providers</a>.</p>\"\
        },\
        \"FilterBBox\":{\
          \"shape\":\"BoundingBox\",\
          \"documentation\":\"<p>Contains the coordinates for the optional bounding box specified in the request.</p>\"\
        },\
        \"FilterCategories\":{\
          \"shape\":\"FilterPlaceCategoryList\",\
          \"documentation\":\"<p>The optional category filter specified in the request.</p>\"\
        },\
        \"FilterCountries\":{\
          \"shape\":\"CountryCodeList\",\
          \"documentation\":\"<p>Contains the optional country filter specified in the request.</p>\"\
        },\
        \"Language\":{\
          \"shape\":\"LanguageTag\",\
          \"documentation\":\"<p>The preferred language used to return results. Matches the language in the request. The value is a valid <a href=\\\"https://tools.ietf.org/search/bcp47\\\">BCP 47</a> language tag, for example, <code>en</code> for English.</p>\"\
        },\
        \"MaxResults\":{\
          \"shape\":\"PlaceIndexSearchResultLimit\",\
          \"documentation\":\"<p>Contains the optional result count limit specified in the request.</p>\"\
        },\
        \"ResultBBox\":{\
          \"shape\":\"BoundingBox\",\
          \"documentation\":\"<p>The bounding box that fully contains all search results.</p> <note> <p>If you specified the optional <code>FilterBBox</code> parameter in the request, <code>ResultBBox</code> is contained within <code>FilterBBox</code>.</p> </note>\"\
        },\
        \"Text\":{\
          \"shape\":\"SensitiveString\",\
          \"documentation\":\"<p>The search text specified in the request.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A summary of the request sent by using <code>SearchPlaceIndexForText</code>.</p>\"\
    },\
    \"SensitiveString\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"ServiceQuotaExceededException\":{\
      \"type\":\"structure\",\
      \"required\":[\"Message\"],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A message with the reason for the service quota exceeded exception error.</p>\",\
          \"locationName\":\"message\"\
        }\
      },\
      \"documentation\":\"<p>The operation was denied because the request would exceed the maximum <a href=\\\"https://docs.aws.amazon.com/location/latest/developerguide/location-quotas.html\\\">quota</a> set for Amazon Location Service.</p>\",\
      \"error\":{\
        \"httpStatusCode\":402,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"Status\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Active\",\
        \"Expired\"\
      ]\
    },\
    \"Step\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Distance\",\
        \"DurationSeconds\",\
        \"EndPosition\",\
        \"StartPosition\"\
      ],\
      \"members\":{\
        \"Distance\":{\
          \"shape\":\"StepDistanceDouble\",\
          \"documentation\":\"<p>The travel distance between the step's <code>StartPosition</code> and <code>EndPosition</code>.</p>\"\
        },\
        \"DurationSeconds\":{\
          \"shape\":\"StepDurationSecondsDouble\",\
          \"documentation\":\"<p>The estimated travel time, in seconds, from the step's <code>StartPosition</code> to the <code>EndPosition</code>. . The travel mode and departure time that you specify in the request determines the calculated time.</p>\"\
        },\
        \"EndPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The end position of a step. If the position the last step in the leg, this position is the same as the end position of the leg.</p>\"\
        },\
        \"GeometryOffset\":{\
          \"shape\":\"StepGeometryOffsetInteger\",\
          \"documentation\":\"<p>Represents the start position, or index, in a sequence of steps within the leg's line string geometry. For example, the index of the first step in a leg geometry is <code>0</code>. </p> <p>Included in the response for queries that set <code>IncludeLegGeometry</code> to <code>True</code>. </p>\"\
        },\
        \"StartPosition\":{\
          \"shape\":\"Position\",\
          \"documentation\":\"<p>The starting position of a step. If the position is the first step in the leg, this position is the same as the start position of the leg.</p>\"\
        }\
      },\
      \"documentation\":\"<p> Represents an element of a leg within a route. A step contains instructions for how to move to the next step in the leg. </p>\"\
    },\
    \"StepDistanceDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"StepDurationSecondsDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"StepGeometryOffsetInteger\":{\
      \"type\":\"integer\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"StepList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Step\"}\
    },\
    \"String\":{\"type\":\"string\"},\
    \"TagKey\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"^[a-zA-Z+-=._:/]+$\"\
    },\
    \"TagKeys\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"String\"},\
      \"max\":50,\
      \"min\":1\
    },\
    \"TagMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"TagKey\"},\
      \"value\":{\"shape\":\"TagValue\"},\
      \"max\":50,\
      \"min\":0\
    },\
    \"TagResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ResourceArn\",\
        \"Tags\"\
      ],\
      \"members\":{\
        \"ResourceArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the resource whose tags you want to update.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:resourcetype/ExampleResource</code> </p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"ResourceArn\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagMap\",\
          \"documentation\":\"<p>Applies one or more tags to specific resource. A tag is a key-value pair that helps you manage, identify, search, and filter your resources.</p> <p>Format: <code>\\\"key\\\" : \\\"value\\\"</code> </p> <p>Restrictions:</p> <ul> <li> <p>Maximum 50 tags per resource.</p> </li> <li> <p>Each tag key must be unique and must have exactly one associated value.</p> </li> <li> <p>Maximum key length: 128 Unicode characters in UTF-8.</p> </li> <li> <p>Maximum value length: 256 Unicode characters in UTF-8.</p> </li> <li> <p>Can use alphanumeric characters (AâZ, aâz, 0â9), and the following characters: + - = . _ : / @</p> </li> <li> <p>Cannot use \\\"aws:\\\" as a prefix for a key.</p> </li> </ul>\"\
        }\
      }\
    },\
    \"TagResourceResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"TagValue\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0,\
      \"pattern\":\"^[A-Za-z0-9 _=@:.+-/]*$\"\
    },\
    \"ThrottlingException\":{\
      \"type\":\"structure\",\
      \"required\":[\"Message\"],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"locationName\":\"message\"\
        }\
      },\
      \"documentation\":\"<p>The request was denied because of request throttling.</p>\",\
      \"error\":{\
        \"httpStatusCode\":429,\
        \"senderFault\":true\
      },\
      \"exception\":true,\
      \"retryable\":{\"throttling\":false}\
    },\
    \"TimeZone\":{\
      \"type\":\"structure\",\
      \"required\":[\"Name\"],\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The name of the time zone, following the <a href=\\\"https://www.iana.org/time-zones\\\"> IANA time zone standard</a>. For example, <code>America/Los_Angeles</code>.</p>\"\
        },\
        \"Offset\":{\
          \"shape\":\"Integer\",\
          \"documentation\":\"<p>The time zone's offset, in seconds, from UTC.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Information about a time zone. Includes the name of the time zone and the offset from UTC in seconds.</p>\"\
    },\
    \"Timestamp\":{\
      \"type\":\"timestamp\",\
      \"timestampFormat\":\"iso8601\"\
    },\
    \"Token\":{\
      \"type\":\"string\",\
      \"max\":2000,\
      \"min\":1\
    },\
    \"TrackingFilterGeometry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Polygon\":{\
          \"shape\":\"LinearRings\",\
          \"documentation\":\"<p>The set of arrays which define the polygon. A polygon can have between 4 and 1000 vertices.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The geomerty used to filter device positions.</p>\"\
    },\
    \"TravelMode\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Car\",\
        \"Truck\",\
        \"Walking\",\
        \"Bicycle\",\
        \"Motorcycle\"\
      ]\
    },\
    \"TruckDimensions\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Height\":{\
          \"shape\":\"TruckDimensionsHeightDouble\",\
          \"documentation\":\"<p>The height of the truck.</p> <ul> <li> <p>For example, <code>4.5</code>.</p> </li> </ul> <note> <p> For routes calculated with a HERE resource, this value must be between 0 and 50 meters. </p> </note>\"\
        },\
        \"Length\":{\
          \"shape\":\"TruckDimensionsLengthDouble\",\
          \"documentation\":\"<p>The length of the truck.</p> <ul> <li> <p>For example, <code>15.5</code>.</p> </li> </ul> <note> <p> For routes calculated with a HERE resource, this value must be between 0 and 300 meters. </p> </note>\"\
        },\
        \"Unit\":{\
          \"shape\":\"DimensionUnit\",\
          \"documentation\":\"<p> Specifies the unit of measurement for the truck dimensions.</p> <p>Default Value: <code>Meters</code> </p>\"\
        },\
        \"Width\":{\
          \"shape\":\"TruckDimensionsWidthDouble\",\
          \"documentation\":\"<p>The width of the truck.</p> <ul> <li> <p>For example, <code>4.5</code>.</p> </li> </ul> <note> <p> For routes calculated with a HERE resource, this value must be between 0 and 50 meters. </p> </note>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details about the truck dimensions in the unit of measurement that you specify. Used to filter out roads that can't support or allow the specified dimensions for requests that specify <code>TravelMode</code> as <code>Truck</code>.</p>\"\
    },\
    \"TruckDimensionsHeightDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"TruckDimensionsLengthDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"TruckDimensionsWidthDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"TruckWeight\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Total\":{\
          \"shape\":\"TruckWeightTotalDouble\",\
          \"documentation\":\"<p>The total weight of the truck. </p> <ul> <li> <p>For example, <code>3500</code>.</p> </li> </ul>\"\
        },\
        \"Unit\":{\
          \"shape\":\"VehicleWeightUnit\",\
          \"documentation\":\"<p>The unit of measurement to use for the truck weight.</p> <p>Default Value: <code>Kilograms</code> </p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains details about the truck's weight specifications. Used to avoid roads that can't support or allow the total weight for requests that specify <code>TravelMode</code> as <code>Truck</code>.</p>\"\
    },\
    \"TruckWeightTotalDouble\":{\
      \"type\":\"double\",\
      \"box\":true,\
      \"min\":0\
    },\
    \"UntagResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"ResourceArn\",\
        \"TagKeys\"\
      ],\
      \"members\":{\
        \"ResourceArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the resource from which you want to remove tags.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:resourcetype/ExampleResource</code> </p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"ResourceArn\"\
        },\
        \"TagKeys\":{\
          \"shape\":\"TagKeys\",\
          \"documentation\":\"<p>The list of tag keys to remove from the specified resource.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"tagKeys\"\
        }\
      }\
    },\
    \"UntagResourceResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"UpdateGeofenceCollectionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CollectionName\"],\
      \"members\":{\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the geofence collection to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CollectionName\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>Updates the description for the geofence collection.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter is no longer used.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. No longer allowed.\"\
        }\
      }\
    },\
    \"UpdateGeofenceCollectionResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CollectionArn\",\
        \"CollectionName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CollectionArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the updated geofence collection. Used to specify a resource across Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollection</code> </p> </li> </ul>\"\
        },\
        \"CollectionName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the updated geofence collection.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time when the geofence collection was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\">ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code> </p>\"\
        }\
      }\
    },\
    \"UpdateKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyName\"],\
      \"members\":{\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>Updates the description for the API key resource.</p>\"\
        },\
        \"ExpireTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>Updates the timestamp for when the API key resource will expire in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        },\
        \"ForceUpdate\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>The boolean flag to be included for updating <code>ExpireTime</code> or <code>Restrictions</code> details.</p> <p>Must be set to <code>true</code> to update an API key resource that has been used in the past 7 days.</p> <p> <code>False</code> if force update is not preferred</p> <p>Default value: <code>False</code> </p>\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key resource to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"KeyName\"\
        },\
        \"NoExpiry\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Whether the API key should expire. Set to <code>true</code> to set the API key to have no expiration time.</p>\"\
        },\
        \"Restrictions\":{\
          \"shape\":\"ApiKeyRestrictions\",\
          \"documentation\":\"<p>Updates the API key restrictions for the API key resource.</p>\"\
        }\
      }\
    },\
    \"UpdateKeyResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyArn\",\
        \"KeyName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"KeyArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) for the API key resource. Used when you need to specify a resource across all Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:key/ExampleKey</code> </p> </li> </ul>\"\
        },\
        \"KeyName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the API key resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the API key resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"UpdateMapRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"MapName\"],\
      \"members\":{\
        \"ConfigurationUpdate\":{\
          \"shape\":\"MapConfigurationUpdate\",\
          \"documentation\":\"<p>Updates the parts of the map configuration that can be updated, including the political view.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>Updates the description for the map resource.</p>\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the map resource to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"MapName\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        }\
      }\
    },\
    \"UpdateMapResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"MapArn\",\
        \"MapName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"MapArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the updated map resource. Used to specify a resource across AWS.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:map/ExampleMap</code> </p> </li> </ul>\"\
        },\
        \"MapName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the updated map resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the map resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"UpdatePlaceIndexRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"IndexName\"],\
      \"members\":{\
        \"DataSourceConfiguration\":{\
          \"shape\":\"DataSourceConfiguration\",\
          \"documentation\":\"<p>Updates the data storage option for the place index resource.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>Updates the description for the place index resource.</p>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the place index resource to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"IndexName\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        }\
      }\
    },\
    \"UpdatePlaceIndexResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"IndexArn\",\
        \"IndexName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"IndexArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the upated place index resource. Used to specify a resource across Amazon Web Services.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:place- index/ExamplePlaceIndex</code> </p> </li> </ul>\"\
        },\
        \"IndexName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the updated place index resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the place index resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"UpdateRouteCalculatorRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CalculatorName\"],\
      \"members\":{\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the route calculator resource to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"CalculatorName\"\
        },\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>Updates the description for the route calculator resource.</p>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        }\
      }\
    },\
    \"UpdateRouteCalculatorResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CalculatorArn\",\
        \"CalculatorName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"CalculatorArn\":{\
          \"shape\":\"GeoArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the updated route calculator resource. Used to specify a resource across AWS.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:route- calculator/ExampleCalculator</code> </p> </li> </ul>\"\
        },\
        \"CalculatorName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the updated route calculator resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the route calculator was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"UpdateTrackerRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"TrackerName\"],\
      \"members\":{\
        \"Description\":{\
          \"shape\":\"ResourceDescription\",\
          \"documentation\":\"<p>Updates the description for the tracker resource.</p>\"\
        },\
        \"EventBridgeEnabled\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Whether to enable position <code>UPDATE</code> events from this tracker to be sent to EventBridge.</p> <note> <p>You do not need enable this feature to get <code>ENTER</code> and <code>EXIT</code> events for geofences with this tracker. Those events are always sent to EventBridge.</p> </note>\"\
        },\
        \"KmsKeyEnableGeospatialQueries\":{\
          \"shape\":\"Boolean\",\
          \"documentation\":\"<p>Enables <code>GeospatialQueries</code> for a tracker that uses a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html\\\">Amazon Web Services KMS customer managed key</a>.</p> <p>This parameter is only used if you are using a KMS customer managed key.</p>\"\
        },\
        \"PositionFiltering\":{\
          \"shape\":\"PositionFiltering\",\
          \"documentation\":\"<p>Updates the position filtering for the tracker resource.</p> <p>Valid values:</p> <ul> <li> <p> <code>TimeBased</code> - Location updates are evaluated against linked geofence collections, but not every location update is stored. If your update frequency is more often than 30 seconds, only one update per 30 seconds is stored for each unique device ID. </p> </li> <li> <p> <code>DistanceBased</code> - If the device has moved less than 30 m (98.4 ft), location updates are ignored. Location updates within this distance are neither evaluated against linked geofence collections, nor stored. This helps control costs by reducing the number of geofence evaluations and historical device positions to paginate through. Distance-based filtering can also reduce the effects of GPS noise when displaying device trajectories on a map. </p> </li> <li> <p> <code>AccuracyBased</code> - If the device has moved less than the measured accuracy, location updates are ignored. For example, if two consecutive updates from a device have a horizontal accuracy of 5 m and 10 m, the second update is ignored if the device has moved less than 15 m. Ignored location updates are neither evaluated against linked geofence collections, nor stored. This helps educe the effects of GPS noise when displaying device trajectories on a map, and can help control costs by reducing the number of geofence evaluations. </p> </li> </ul>\"\
        },\
        \"PricingPlan\":{\
          \"shape\":\"PricingPlan\",\
          \"documentation\":\"<p>No longer used. If included, the only allowed value is <code>RequestBasedUsage</code>.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. If included, the only allowed value is RequestBasedUsage.\"\
        },\
        \"PricingPlanDataSource\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>This parameter is no longer used.</p>\",\
          \"deprecated\":true,\
          \"deprecatedMessage\":\"Deprecated. No longer allowed.\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the tracker resource to update.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"TrackerName\"\
        }\
      }\
    },\
    \"UpdateTrackerResponse\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TrackerArn\",\
        \"TrackerName\",\
        \"UpdateTime\"\
      ],\
      \"members\":{\
        \"TrackerArn\":{\
          \"shape\":\"Arn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the updated tracker resource. Used to specify a resource across AWS.</p> <ul> <li> <p>Format example: <code>arn:aws:geo:region:account-id:tracker/ExampleTracker</code> </p> </li> </ul>\"\
        },\
        \"TrackerName\":{\
          \"shape\":\"ResourceName\",\
          \"documentation\":\"<p>The name of the updated tracker resource.</p>\"\
        },\
        \"UpdateTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The timestamp for when the tracker resource was last updated in <a href=\\\"https://www.iso.org/iso-8601-date-and-time-format.html\\\"> ISO 8601</a> format: <code>YYYY-MM-DDThh:mm:ss.sssZ</code>. </p>\"\
        }\
      }\
    },\
    \"ValidationException\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"FieldList\",\
        \"Message\",\
        \"Reason\"\
      ],\
      \"members\":{\
        \"FieldList\":{\
          \"shape\":\"ValidationExceptionFieldList\",\
          \"documentation\":\"<p>The field where the invalid entry was detected.</p>\",\
          \"locationName\":\"fieldList\"\
        },\
        \"Message\":{\
          \"shape\":\"String\",\
          \"locationName\":\"message\"\
        },\
        \"Reason\":{\
          \"shape\":\"ValidationExceptionReason\",\
          \"documentation\":\"<p>A message with the reason for the validation exception error.</p>\",\
          \"locationName\":\"reason\"\
        }\
      },\
      \"documentation\":\"<p>The input failed to meet the constraints specified by the AWS service. </p>\",\
      \"error\":{\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"ValidationExceptionField\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Message\",\
        \"Name\"\
      ],\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A message with the reason for the validation exception error.</p>\",\
          \"locationName\":\"message\"\
        },\
        \"Name\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The field name where the invalid entry was detected.</p>\",\
          \"locationName\":\"name\"\
        }\
      },\
      \"documentation\":\"<p>The input failed to meet the constraints specified by the AWS service in a specified field. </p>\"\
    },\
    \"ValidationExceptionFieldList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ValidationExceptionField\"}\
    },\
    \"ValidationExceptionReason\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"UnknownOperation\",\
        \"Missing\",\
        \"CannotParse\",\
        \"FieldValidationFailed\",\
        \"Other\"\
      ]\
    },\
    \"VehicleWeightUnit\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Kilograms\",\
        \"Pounds\"\
      ]\
    }\
  },\
  \"documentation\":\"<p>\\\"Suite of geospatial services including Maps, Places, Routes, Tracking, and Geofencing\\\"</p>\"\
}\
";
}

@end
