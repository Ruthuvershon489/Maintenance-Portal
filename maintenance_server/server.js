import express from 'express';
const app = express();
import fetch from 'node-fetch';
import base64 from 'base-64';
import xml2js from 'xml2js';
import body_parser from 'body-parser';
import cors from 'cors';
import date from 'date-and-time';

app.use(body_parser.urlencoded({extended: true}));

app.use(body_parser.json());

//  // For pipo cred
const pipo_username = "pouser@2"
const pipo_password = "2022@Tech"   

app.use(cors({
    origin: ["http://localhost:4200"]
}));

const PORT = process.env.PORT || 3090;

var server_username;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


app.post('/login', async (req, res) => {
    console.log(req.body);
    server_username = req.body.uname;
    var req_url = "http://dxktpipo.kaarcloud.com:50000/XISOAPAdapter/MessageServlet?senderParty=&senderService=BC_RUTHU_MAINT_LOGIN&receiverParty=&receiverService=&interface=SI_RUTHU_MAINT_LOGIN&interfaceNamespace=http://ruthu_maint.com";
    var req_xml = `<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
                        <soapenv:Header/>
                        <soapenv:Body>
                        <urn:ZRUTHU_MAINT_LOGIN_FM>
                            <!--You may enter the following 2 items in any order-->
                            <PASSWORD>${req.body.password}</PASSWORD>
                            <USERNAME>${server_username}</USERNAME>
                        </urn:ZRUTHU_MAINT_LOGIN_FM>
                        </soapenv:Body>
                    </soapenv:Envelope>`

    const login_res = await fetch(req_url, {
        method: 'POST',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'include',
        headers:{
            'Content-Type': 'text/xml',
            'Authorization': 'Basic ' + base64.encode(pipo_username + ':' + pipo_password)
            },
        redirect: 'follow',
        referrerPolicy: 'no-referrer',
        body: req_xml
    }).then(res => res.text())

    xml2js.parseString(login_res, (err, data) => {
        if(err){
            console.log(err);
        }
        else{
            console.log(data);
            var code;
            var verify_data = data['SOAP:Envelope']['SOAP:Body'][0]['rfc:ZRUTHU_MAINT_LOGIN_FM.Response'][0]['MESSAGE']
            // var name_data = data['SOAP:Envelope']['SOAP:Body'][0]['rfc:ZRUTHU_VP_LOGIN_FM.Response'][0]['NAME']
            // var out_data =[verify_data, name_data]
            if(verify_data == "LOGIN SUCCESSFUL"){
                code = 1;
            }
            else{
                code = 0;
            }
            // var out_data = {
            //     "code":code
            //     };
            var out_data = [code];
            console.log(out_data);
            res.send(out_data);
        }
    });
});


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* <NOTIFICATION_DATE>20220505</NOTIFICATION_DATE>
<PLANNER_GROUP>010</PLANNER_GROUP>
<PLANNING_PLANT>0001</PLANNING_PLANT> */

app.post('/notification', async (req, res) => {
    console.log(req.body);
    var req_url = "http://dxktpipo.kaarcloud.com:50000/XISOAPAdapter/MessageServlet?senderParty=&senderService=BC_RUTHU_MAINT_NOTIFICATION&receiverParty=&receiverService=&interface=SI_RUTHU_MAINT_NOTIFICATION&interfaceNamespace=http://ruthu_maint.com";
    var req_xml = `<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
                        <soapenv:Header/>
                        <soapenv:Body>
                        <urn:ZRUTHU_MAINT_NOTIFICATION_FM>

                            <NOTIFICATION_DATE>${req.body.date}</NOTIFICATION_DATE>
                            <PLANNER_GROUP>${req.body.group}</PLANNER_GROUP>
                            <PLANNING_PLANT>${req.body.plant}</PLANNING_PLANT>
                            
                        </urn:ZRUTHU_MAINT_NOTIFICATION_FM>
                        </soapenv:Body>
                    </soapenv:Envelope>`

    const invoice_res = await fetch(req_url, {
        method: 'POST',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'include',
        headers:{
            'Content-Type': 'text/xml',
            'Authorization': 'Basic ' + base64.encode(pipo_username + ':' + pipo_password)
            },
        redirect: 'follow',
        referrerPolicy: 'no-referrer',
        body: req_xml
    }).then(res => res.text())

    xml2js.parseString(invoice_res, (err, data) => {
        if(err){
            console.log(err);
        }
        else{
            var out_data = data['SOAP:Envelope']['SOAP:Body'][0]['rfc:ZRUTHU_MAINT_NOTIFICATION_FM.Response'][0]['NOTIFICATION_LIST'][0]['item']
            
            if(out_data == null){
                console.log("emptyyyyyyyyyy")
            }
            else {
                out_data.forEach(function (table) {
                    /////////////   Preceeding 0's    ////////////////
                    Object.entries(table).forEach(([key, value]) => {
                        table[key] = String(table[key]).replace(/^0+/, "");
                      });

                      /////////////   Empty replace    /////////////////
                    Object.entries(table).forEach(([key, value]) => {
                        if(value == "" || value == null){
                            table[key] = "TBA";
                        }
                      });
            });

            /////////////////   DATE    /////////////////////
            out_data.forEach(function (table) {
                Object.entries(table).forEach(([key, value]) => {
                    if(key == 'NOTIFDATE' || key == 'COMPLETION' || key == 'STARTDATE'
                       || key == 'ENDDATE' || key == 'PURCH_DATE') {
                        if(table[key] == "-00-00" || table[key] == "") {
                            table[key] = "TBA"
                        }
                        else {
                            const now = new Date(table[key]);
                            table[key] = date.format(now, 'DD-MM-YYYY');
                        }
                    }
                  })
                });
            }
            // console.log(out_data);
            res.send(out_data);
        }
    });
});


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ${req.body.group}
// ${req.body.plant}

app.post('/workorder', async (req, res) => {
    console.log(req.body);
    var req_url = "http://dxktpipo.kaarcloud.com:50000/XISOAPAdapter/MessageServlet?senderParty=&senderService=BC_RUTHU_MAINT_WORKORDER&receiverParty=&receiverService=&interface=SI_RUTHU_MAINT_WORKORDER&interfaceNamespace=http://ruthu_maint.com";
    var req_xml = `<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:sap-com:document:sap:rfc:functions">
                        <soapenv:Header/>
                        <soapenv:Body>
                        <urn:ZRUTHU_MAINT_WORKORDER_FM>

                            <PLANNER_GROUP>${req.body.group}</PLANNER_GROUP>
                            <PLANNING_PLANT>${req.body.plant}</PLANNING_PLANT>
                            
                        </urn:ZRUTHU_MAINT_WORKORDER_FM>
                        </soapenv:Body>
                    </soapenv:Envelope>`

    const work_res = await fetch(req_url, {
        method: 'POST',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'include',
        headers:{
            'Content-Type': 'text/xml',
            'Authorization': 'Basic ' + base64.encode(pipo_username + ':' + pipo_password)
            },
        redirect: 'follow',
        referrerPolicy: 'no-referrer',
        body: req_xml
    }).then(res => res.text())

    xml2js.parseString(work_res, (err, data) => {
        if(err){
            console.log(err);
        }
        else{
            var out_data = data['SOAP:Envelope']['SOAP:Body'][0]['rfc:ZRUTHU_MAINT_WORKORDER_FM.Response'][0]['WORK_ORDER_LIST'][0]['item'];
            
            if(out_data == null){
                console.log("emptyyyyyyyyyy")
            }
            else {
                out_data.forEach(function (table) {
                    /////////////   Preceeding 0's    ////////////////
                    Object.entries(table).forEach(([key, value]) => {
                        table[key] = String(table[key]).replace(/^0+/, "");
                      });

                      /////////////   Empty replace    /////////////////
                    Object.entries(table).forEach(([key, value]) => {
                        if(value == "" || value == null){
                            table[key] = "TBA";
                        }
                    });
                });
                /////////////////   DATE    /////////////////////
                out_data.forEach(function (table) {
                    Object.entries(table).forEach(([key, value]) => {
                        if (key == 'EARL_SCHED_START_DATE' || key == 'LATE_SCHED_START_DATE' || key == 'EARL_SCHED_FINISH_DATE'
                            || key == 'LATE_SCHED_FIN_DATE') {
                            if (table[key] == "-00-00" || table[key] == "") {
                                table[key] = "TBA"
                            }
                            else {
                                const now = new Date(table[key]);
                                table[key] = date.format(now, 'DD-MM-YYYY');
                            }
                        }
                    })
                });
            }
            // console.log(out_data);
            res.send(out_data);
        }
    });
});


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


app.listen(PORT, () => {
    console.log("server listening on 3090");
  });