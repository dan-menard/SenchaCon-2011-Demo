
// Definition and initialization of PhoneGap calls.

var PatientRecordService = function() {

}

PatientRecordService.prototype.getPatientList = function(onSuccess, onFailure) {
    return PhoneGap.exec("PatientPlugin.getPatientList",
    {
        "successCallback" : GetFunctionName(onSuccess),
        "failureCallback" : GetFunctionName(onFailure)
    });
}

PatientRecordService.prototype.getPatientDetails = function(pid, onSuccess, onFailure) {
    return PhoneGap.exec("PatientPlugin.getPatientDetails",
    {
        "successCallback" : GetFunctionName(onSuccess),
        "failureCallback" : GetFunctionName(onFailure),
        "pid" : pid
    });
}

if( !window.services )
{
    window.services = {};
}

window.services.prService = new PatientRecordService();
