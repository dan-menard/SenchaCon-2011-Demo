// Setup/Config.
var url = require('url');
var http = require('http');

var GET_PATIENT_LIST = "/getPatientList";
var GET_PATIENT_DETAILS = "/getPatientDetails";

// Model data.
var patientData = [
	{
		pid: 0,
		firstName: 'Dan',
		lastName: 'Menard',
		diagnosis: 'Galeophobia',
		physician: 'Simon Tam',
        note: 'Great developer, cool dude. Not so much into deep-sea diving.'
	},
	{
		pid: 1,
		firstName: 'Tony',
		lastName: 'Hooper',
		diagnosis: 'Schizophrenia',
		physician: 'Dr. Horrible',
        note: 'Great manager, crazy guy. Breaks into showtunes during meetings.'
	}
];

// Server logic.
var patientServer = function (req, res) {
	var parsedUrl = url.parse(req.url, true);
	
	switch (parsedUrl.pathname)
	{
		// Return a list of basic patient information.
		case GET_PATIENT_LIST:
		{
			var resultList = [];
			
			for (var i=0; i<patientData.length; i++) {
				resultList.push({
                    pid: patientData[i].pid,
					firstName: patientData[i].firstName,
					lastName: patientData[i].lastName
				});
			}
			
			res.writeHead(200, {'Content-Type': 'text/plain'});
			res.end(JSON.stringify({'patientList' : resultList}));
		}
		
		// Return all details for a specific patient.
		case GET_PATIENT_DETAILS:
		{
			var resultStr;
			var pid = parsedUrl.query.pid;
			
			if (pid) {
				resultStr = JSON.stringify(patientData[pid]);
			}
			else {
				resultStr = 'Missing parameter to /getPatientDetails: pid';
			}
			
			res.writeHead(200, {'Content-Type': 'text/plain'});
			res.end(resultStr);
		}
		
		default:
		{
			res.writeHead(200, {'Content-Type': 'text/plain'});
			res.end('Error: Unrecognized request URL.\n');
		}
	}
}

// Start the server!
http.createServer(patientServer).listen(8127, "127.0.0.1");
console.log('Server running at http://127.0.0.1:8127/');
