class HelperFunction{
  	
    List<Object> checkIsRootedOrJailBroken(){
      DateTime dateTime = DateTime.now();
      String timeZoneName = dateTime.timeZoneName;
      Duration timeZoneOffset = dateTime.timeZoneOffset;

      return [timeZoneName,timeZoneOffset, ];
  
      // setState(() {
      //   _timeZoneName = timeZoneName;
      //   _timeZoneOffset = timeZoneOffset;
      // });
    }
}