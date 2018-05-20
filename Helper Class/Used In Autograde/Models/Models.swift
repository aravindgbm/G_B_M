//
//  Models.swift
//  AutoGradeVTS
//
//  Created by Appzoc on 29/01/18.
//  Copyright © 2018 Appzoc. All rights reserved.
//

import Foundation

//Mark:- 6. Login Response - "userdata"

struct LoginResponse: Codable {
    let status:Int
    let userdata:UserData?
    let message:String
}



struct UserData: Codable {
    let user_id:String
    let client_id:String
    let client_name:String
    let user_name:String
    let is_clientAdmin:String
    let is_Admin:String
    let timezone_id:String
    let timezone_diff:String
    let timezone_name:String
    let distributor_id:String
    let distributor_name:String
    let dealer_id:String
    let dealer_name:String
    let parent_id:String?
    let parent_name:String?
    let user_type_id:String
}

/*
 "{
 ""status"": true,
 ""userdata"": {
    ""user_id"": ,
    ""client_id"": ,
    ""client_name"": ,
    ""user_name"": ,
    ""is_clientAdmin"": ,
    ""is_Admin"": ,
    ""timezone_id"": ,
    ""timezone_diff"": ,
    ""timezone_name"": ,
    ""distributor_id"": ,
    ""distributor_name"": ,
    ""dealer_id"": ,
    ""dealer_name"": ,
    ""parent_id"": ,
    ""parent_name"": ,
    ""user_type_id"":
 
    },
 ""message"": ""Login success""
 }
 
 {
 ""status"": false,
 ""message"": ""Incorrect username or password""
 }"
 */


//Mark:- 7. All Vehicle Count
struct AllVehicleCount:Codable {
    let status:Bool
    let all_count:Int
    let lost:Int
    let stop:Int
    let move:Int
    let halt:Int
}
/*
 "{
 ""status"": true,
 ""all_count"": ,
 ""lost"": ,
 ""stop"": ,
 ""move"": ,
 ""halt"":
 }"
 */

//Mark:- 8. All Vehicle List - "vehicles"
struct AllVehicleList: Codable {
    let vhid:String
    let imei:String
    let received_time:String
    let diff:String
    let vehicle_reg_no:String
    let vehicle_type:String
    let driver_name:String
    let speed:String
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
    let vehicle_status:String
}

struct VehicleListing: Codable {
    let status:Int
    let vehicles:[AllVehicleList]
}

/*
 "{
 ""status"": true,
 ""vehicles"": [
    {
    ""vhid"": ,
    ""imei"": ,
    ""received_time"": ,
    ""diff"": ,
    ""vehicle_reg_no"": ,
    ""vehicle_type"":,
    ""driver_name"":,
    ""speed"": ,
    ""lat"": ,
    ""lng"": ,
    ""latlng"": ,
    ""ignition_status"": ,
    ""vehicle_status"":
    }
    ]
 }"
 */

//Mark:- 9 Connection Lost Vehicles

struct VehicleListingLost: Codable {
    let status:Int
    let lost_conections:[ConnectionLostVehicleList]
}

struct ConnectionLostVehicleList: Codable {
    let vhid:String
    let imei:String
    let received_time:String
    let diff:String
    let vehicle_reg_no:String
    let vehicle_type:String
    let driver_name:String
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
}


//Mark:- 10 Moving Vehicle List

struct VehicleListingMoving: Codable {
    let status:Int
    let moving:[MovingVehiclesList]
}

struct MovingVehiclesList: Codable {
    let vhid:String
    let imei:String
    let received_time:String
    let diff:String
    let vehicle_reg_no:String
    let vehicle_type:String?
    let driver_name:String?
    let speed:String?
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
    let live_driver_name:String?
}

//Mark:- 11 Stopped Vehicle List

struct VehicleListingStop: Codable {
    let status:Int
    let stopped:[StoppedVehicleList]
}

struct StoppedVehicleList:Codable {
    let vhid:String
    let imei:String
    let received_time:String
    let diff:String
    let vehicle_reg_no:String
    let driver_name:String
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
}

//Mark:- 12 Idle Vehicles List "halted"

struct VehicleListingHalt: Codable {
    let status:Int
    let halted:[IdleVehiclesList]
}

struct IdleVehiclesList: Codable {
    let vhid:String
    let imei:String
    let received_time:String
    let diff:String
    let vehicle_reg_no:String
    let vehicle_type:String
    let driver_name:String
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
}

//Mark:- 13 Vehicle Group ["vehicle_groups"]

struct VehicleGroups:Codable{
    let clientid:Int
    let vehiclegroupid:Int
    let vehiclegroupname:String
}

/*
 "{
    ""status"": true,
    ""vehicle_groups"": [
        {
        ""clientid"": ,
        ""vehiclegroupid"": ,
        ""vehiclegroupname"":
        }
 
    ]
 }"
 */

//Mark:- 14 Vehicles List "vehicles"

struct VehicleList:Codable {
    let id:Int
    let value:Int
}

//Mark:- 15 Driver Group "driver_groups"

struct DriverGroups:Codable {
    let driver_group_id:Int
    let driver_group:String
}

//Mark:- 16 Driver List "drivers"

struct DriverList:Codable {
    let driver_id:Int
    let driver_name:String
}

/*
"{
""status"": true,
""trips"": [
{
""live_trip_data_id"": ,
""vts_live_trip_id"": ,
""vts_vehicle_id"": ,
""fuel"": ,
""odometer_reading"": ,
""distance_travelled"": ,
""trip_name"":
""vehicle_mileage"":
}
]
}"
*/

struct TripManagementResponse: Codable
{
    let status : Int
    let trips : [tripManagement]
}

struct tripManagement: Codable
{
    let live_trip_data_id : String?
    let vts_live_trip_id : String?
    let vts_vehicle_id : String?
    let fuel : String!
    let odometer_reading : Double!
    let distance_travelled : Double!
    let trip_name : String?
    let vehicle_mileage : String!
}

struct TripnameList: Codable
{
    let status : Int
    let trips : [tripname]
}

struct tripname: Codable
{
    let trip_id : String
    let trip_name : String
}

struct saveTrip : Codable
{
    let status : Int
    let message : String
}

//Mark:- 17 Utilization Report "data" -> ["YYYY-mm-dd"]

struct UtilizationReport:Codable {
    let start_time:String
    let end_time:String
    let starting:String
    let ending:String
    let distance:String
    let work_time:String
    let idle:String
}

/*
 {
""status"": true,
""data"": {
    ""YYYY-mm-dd"": [
    {
    ""start_time"": ,
    ""end_time"": ,
    ""starting"": ,
    ""ending"": ,
    ""distance"": ,
    ""work_time"": ,
    ""idle"":
    },
    
    ]
}
}
*/

//Mark:- 18 Speed Violations

struct SpeedViolations:Codable {
    let status:String
    let data:[SpeedViolationsData]
    let report_title:String
    let report_sub_title:String
}

struct SpeedViolationsData:Codable {
    let slno:Int
    let vehicleid:Int
    let imeino:Int
    let from_datetime:String
    let to_datetime:String
    let duration:Int
    let maxspeed:Int
    let avgspeed:Int
    let speedlimit:Int
    let vehicle:String
    let driver:String
    let latitude:String
    let longitude:String
    let driver_id:String
    let spot:String
}




/*
{
 ""status"": ,
 ""data"": [
    {
        ""slno"": ,
        ""vehicleid"": ,
        ""imeino"": ,
        ""from_datetime"": ,
        ""to_datetime"": ,
        ""duration"": ,
        ""maxspeed"": ,
        ""avgspeed"": ,
        ""speedlimit"": ,
        ""vehicle"": ,
        ""driver"": ,
        ""latitude"": ,
        ""longitude"": """",
        ""driver_id"": """",
        ""spot"": ""( Latitude -  , Longitude - )""
    }
 ],
 ""report_title"": "" "",
 ""report_sub_title"": ""For the period from 2017-01-31 to 2017-01-31, Vehicle Name: ( DL-0 11-TC-0011)""
 
}
*/

//Mark:- 19 Work Reports "data"

struct WorkReports:Codable {
    let vehicle_number:Int
    let runtime:String
    let halthr:String
    let distance:String
}

/*
"{
""status"": true,
""data"": [
{
""vehicle_number"": ,
""runtime"": ,
""halthr"": ,
""distance"":
}
]
}"
*/

//Mark:- 20 Clients "data"

struct ClientList:Codable {
    let client_id:String
    let client_name:String
}

//Mark:- 21 Vehicle Live Details "vehicle_details"
/*
 {
 "status": true,
 "vehicle_details":
 {
 "vcle_id": "154",
 "vcle_reg_number": "DL-0 11-TC-0011",
 "vehicle_type": "Car",
 "vcle_speed_limit": "60",
 "live_latitude": "23.37295",
 "live_longitude": "85.3182833333333",
 "speed": "0",
 "max_speed": "40.9292",
 "avg_speed": "5.6290884283247",
 "driver_name": "DA9",
 "last_seen": "2018-02-16 16:19:26",
 "runtime": "1 :2 ",
 "idle_time": "2 :15",
 "stop_time": "13:0 ",
 "distance": 22.24,
 "seat_belt": null,
 "door": null,
 "engine": null,
 "ac": null,
 "temperature": null
 }
 }
 */
struct VehicleDetails:Codable
{
    let vcle_id:String?
    let vcle_reg_number:String?
    let vcle_speed_limit:String?
    let live_latitude:String!
    let live_longitude:String!
    let speed:String?
    let max_speed:String?
    let avg_speed:String?
    let driver_name:String?
    let runtime:String!
    let idle_time:String!
    let stop_time:String!
    let vehicle_type:String?
    let last_seen:String?
    let distance:Double?
}

struct VehicleDetailReponse: Codable {
    let status:Int
    let vehicle_details:VehicleDetails
}


/*
"{
""status"": true,
""vehicle_details"": {
    ""vcle_id"": """",
    ""vcle_reg_number"": """",
    ""vcle_speed_limit"": """",
    ""live_latitude"": """",
    ""live_longitude"": """",
    ""speed"": """",
    ""max_speed"": """",
    ""avg_speed"": """",
    ""driver_name"": """",
""runtime"": "" "",
""idle_time"": "" "",
""stop_time"": "" ""
}
}"
 */


/*
"runtime": "15:16",
"halthr": "27:48",
"stop_time": "209:9 ",
"run_percentage": 6.06,
"stop_percentage": 82.92,
"halt_percentage": 11.02
*/

struct usage : Codable
{
    let runtime : String!
    let halthr : String!
    let stop_time : String!
    let run_percentage : Double!
    let stop_percentage : Double!
    let halt_percentage : Double!
    
}

struct UsageResponse : Codable
{
    let status : Int
    let data : usage
}


// Search

/*
 "{
 ""status"": true,
 ""vehicles"": [
 {
 ""vhid"": ,
 ""imei"": ,
 ""received_time"": ,
 ""diff"": ,
 ""vehicle_reg_no"": ,
 ""vehicle_type"": ,
 ""driver_name"": ,
 ""speed"": ,
 ""lat"": ,
 ""lng"": ,
 ""latlng"": ,
 ""ignition_status"": ,
 ""vehicle_status"":
 }
 ]
 }"
 
 */

struct searchDetails:Codable
{
    let vhid:String
    let imei:String
    let received_time:String
    let diff:String
    let vehicle_reg_no:String
    let vehicle_type:String
    let driver_name:String
    let speed:String
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
    let vehicle_status:String
}

struct SearchResponse: Codable {
    let status:Int
    let vehicles:[searchDetails]
}


//Mark:22 Insurance Alerts ["insurance_details"]


struct InsuranceAlerts {
    let vhid:String
    let vehicle_reg_no:String
    let insurance_agency:String
    let vehicle_insurancepolicynumber:String
    let vehicle_insurancepolicytype:String
    let vehicle_insuranceterms:String
    let diff:String
}


/*
"{
    ""status"": true,
    ""insurance_details"": [
        {
            ""vhid"": ""153"",
            ""vehicle_reg_no"": ""JH-01-AT-5315"",
            ""insurance_agency"": ,
            ""vehicle_insurancepolicynumber"": ,
            ""vehicle_insurancepolicytype"": ,
            ""vehicle_insuranceexpirydate"": ,
            ""vehicle_insuranceterms"": ,
            ""diff"": ""-172""
        }
    ]
}"
*/


//Mark:- 23 Shift Alerts "shift_data"

struct ShiftAlerts:Codable {
    let id:String
    let driver_name:String
    let vehicle_reg_no:String
    let shift_name:String
    let trip_register_time_start:String
    let trip_register_time_end:String
    let diff:String
}
/*
"{
""status"": true,
""shift_data"": [
{
""id"": "",
""driver_name"": ,
""vehicle_reg_no"": ,
""shift_name"": ,
""trip_register_time_start"": ,
""trip_register_time_end"": ,
""diff"":
}


]
}"
 */

//Mark:- 24 Power Alerts ["power_alert"]

struct PowerAlerts:Codable {
    let notify_id:String
    let vehicle_reg_no:String
    let imei:String
    let dt:String
}

/*
"{
""status"": true,
""power_alert"": [
{
""notify_id"":
""vehicle_reg_no"": ,
""imei"": ,
""dt"": ,

}
]
}"
*/


//Mark:- 25 Tamper Alerts ["tamper_alert"]

struct TamperAlerts:Codable {
    let notify_id:String
    let vehicle_reg_no:String
    let imei:String
    let dt:String
    let pw:String
    let tp:String
}

/*

"{
""status"": true,
""tamper_alert"": [
{
""notify_id"":,
""vehicle_reg_no"": ,
""imei"": ,
""dt"": ,
""pw"": ,
""tp"":
},
]
}"
 */


//Mark:- 26 Usages "data"

struct UsagesData:Codable {
    let runtime:String
    let halthr:String
    let stop_time:String
    let run_percentage:String
    let stop_percentage:String
    let halt_percentage:String
}

/*
"{
""status"": true,
""data"": {
    ""runtime"": """",
    ""halthr"": """",
    ""stop_time"": """",
""run_percentage"": ,
""stop_percentage"": ,
""halt_percentage"":
}
}"
 */

//Mark:- 27 Live Tracking ["gps_data"]

struct LiveTrackingData:Codable {
    let ang:String
    let lat:String
    let lng:String
    let speed:String
    let vehicle:String
    let driver:String
    let speedLimit:String
    let status:String
    let dateTime:String
}

/*
"{
""status"": true,
""gps_data"": [
    {
        ""ang"": ,
        ""lat"": ,
        ""lng"": ,
        ""speed"": ,
        ""vehicle"": ,
        ""driver"": ,
        ""speedLimit"": ,
        ""status"": ,
        ""dateTime"":
    }
 ]
}"
 */

//Mark:- 28 History Tracking ["gps_data"]

struct HistoryTrackingData:Codable {
    let ang:String
    let status:String
    let driver:String
    let vehicle:String
    let speedLimit:String
    let lat:String
    let lng:String
    let speed:String
    let dateTime:String
}

struct HistoryTrackingDataResponse:Codable
{
    let status : Int
    let gps_data :[HistoryTrackingData]
}


/*
 "{
 ""status"": true,
 ""gps_data"": [
 {
 ""ang"": """",
 ""status"": """",
 ""driver"": """",
 ""vehicle"": """",
 ""speedLimit"": """",
 ""lat"": """",
 ""lng"": """",
 ""speed"": """",
 ""dateTime"": """"
 },"
 */


//Mark:- 29 Logout

struct LogoutData:Codable {
    let status:Bool
    let message:String
}

/*
 "{
 ""status"": true,
 ""message"": ""You have logged out successfully""
 }"
 */

//Mark:- 30 Dashboard - get vehicle count

struct Dashboard:Codable {
    let status:String
    let all_count:Int
    let lost:Int
    let move:Int
    let halt:Int
    let notifications_count:Int
}

/*
 "{
 ""status"": ,
 ""all_count"": ,
 ""lost"": ,
 ""stop"": ,
 ""move"": ,
 ""halt"": ,
 ""notifications_count"":
 }"
 
 */

//Mark:- 31 Spot Vehicle "vehicles"

struct SpotVehicleData:Codable {
    let vhid:String
    let imei:String
    let received_time:String
    let deff:String
    let vehicle_reg_no:String
    let vehicle_type:String
    let driver_name:String
    let speed:String
    let lat:String
    let lng:String
    let latlng:String
    let ignition_status:String
    let vehicle_status:String
}

/*
 "{
 ""status"": true,
 ""vehicles"": [
 {
 ""vhid"": ,
 ""imei"": ,
 ""received_time"": ,
 ""diff"": ,
 ""vehicle_reg_no"": ,
 ""vehicle_type"": ,
 ""driver_name"": ,
 ""speed"": ,
 ""lat"": ,
 ""lng"": ,
 ""latlng"": ,
 ""ignition_status"": ,
 ""vehicle_status"":
 }
 ]
 }"
 
 */


//Mark:- 32 Trip List "trips"

struct TripList:Codable {
    let trip_id:String
    let trip_name:String
}

/*
 "{
    ""status"":true,""
    trips"":[
        {""trip_id"":,
        ""trip_name"":
        }
    ]
 }"
 
 */

//Mark:- 33 Trip Details "trips"

struct TripDetails:Codable {
    let live_trip_data_id:String
    let vts_live_trip_id:String
    let vts_vehicle_id:String
    let fuel:String
    let odometer_reading:String
    let distance_travelled:String
    let trip_name:String
    let vehicle_mileage:String
}

/*
 "{
 ""status"": true,
 ""trips"": [
 {
 ""live_trip_data_id"": ,
 ""vts_live_trip_id"": ,
 ""vts_vehicle_id"": ,
 ""fuel"": ,
 ""odometer_reading"": ,
 ""distance_travelled"": ,
 ""trip_name"":
 ""vehicle_mileage"":
 }
 ]
 }"
 */


//Mark:- 34 Update trips

struct UpdateTrips:Codable {
    let status:Bool
    let message:String
}
/*
 "{
 ""status"": true,
 ""message"": ""updated successfully""
 }"
 */


//Mark:- 35 NotificationData ["notifications"]

struct NotificationData:Codable {
    let notify_type:String
    let notify_id:String
    let notify_msg:String
    let imei:String
    let vehicle_reg_no:String
    let dt:String
}

/*
 "{ ""status"": true, ""notifications"": [
 {
 ""notify_type"": ,
 ""notify_id"": ,
 ""notify_msg"": ,
 ""imei"": ,
 ""vehicle_reg_no"": ,
 ""dt"": [yyyy-mm-dd H:m:s]
 }
 ]
 }"
 */

//Mark:- 36 Hide Notifications

struct HideNotifications:Codable {
    let status:Bool
    let Message:String
}

/*
 {"status":true,"Message":"Read status updated"}
 */


//Mark:- 37 Speed Alert ["speed_alert"]

struct SpeedAlert:Codable {
    let notify_id:Int
    let imei:Int
    let vehicle_reg_no:Int
    let dt:String
}

/*
 "{
 ""status"": true,
 ""speed_alert"": [
 {
 ""notify_id"": ,
 ""imei"": ,
 ""vehicle_reg_no"": ,
 ""dt"":
 }
 ]
 }"
 
 */
