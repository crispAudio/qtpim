/****************************************************************************
**
** Copyright (C) 2012 Nokia Corporation and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:LGPL$
** GNU Lesser General Public License Usage
** This file may be used under the terms of the GNU Lesser General Public
** License version 2.1 as published by the Free Software Foundation and
** appearing in the file LICENSE.LGPL included in the packaging of this
** file. Please review the following information to ensure the GNU Lesser
** General Public License version 2.1 requirements will be met:
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights. These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU General
** Public License version 3.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of this
** file. Please review the following information to ensure the GNU General
** Public License version 3.0 requirements will be met:
** http://www.gnu.org/copyleft/gpl.html.
**
** Other Usage
** Alternatively, this file may be used in accordance with the terms and
** conditions contained in a signed written agreement between you and Nokia.
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

//TESTED_COMPONENT=src/organizer

import QtQuick 2.0
import QtTest 1.0
import QtOrganizer 5.0

TestCase {
    name: "ModelTests"
    id:modelTests

    property var signalWaitTime : 300

    QOrganizerTestUtility {
        id: utility
    }

    property Rectangle rect: Rectangle {
        id:myRectangle
    }

    function test_componentCreation_data() {
        return [
                // OrganizerModel
                {tag: "No properties",
                 code: "import QtQuick 2.0\n"
                    + "import QtOrganizer 5.0 \n"
                    + "   OrganizerModel {\n"
                    + "   }"
                },
                {tag: "Only id property",
                 code: "import QtQuick 2.0\n"
                   + "import QtOrganizer 5.0\n"
                   + "    OrganizerModel {\n"
                   + "        id:organizerModelId\n"
                   + "     }\n"
                },
                {tag: "Valuetype properties",
                 code: "import QtQuick 2.0\n"
                   + "import QtOrganizer 5.0\n"
                   + "    OrganizerModel {\n"
                   + "        id:organizerModelId\n"
                   + "        manager:'memory'\n"
                   + "        startPeriod:'2010-08-12T13:22:01'\n"
                   + "        endPeriod:'2010-09-12T13:22:01'\n"
                   + "     }\n"
                },
                {tag: "With filter",
                 code: "import QtOrganizer 5.0\n"
                   + "OrganizerModel {\n"
                   + "    id:organizerModelId\n"
                   + "    filter:DetailFilter{\n"
                   + "        id:filter\n"
                   + "        field:EventTime.FieldStartDateTime\n"
                   + "        value:'2010-08-12T13:22:01'\n"
                   + "    }\n"
                   + "}\n"
                },
                {tag: "With invalid filter",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerModel {\n"
                    + "   id:organizerModelId\n"
                    + "   filter:InvalidFilter{\n"
                    + "       id:filter\n"
                    + "   }\n"
                    + "}\n"
                },
                {tag: "With range filter",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerModel {\n"
                    + "   id:organizerModelId\n"
                    + "   filter:DetailRangeFilter{\n"
                    + "       id:filter\n"
                    + "       field:EventTime.FieldStartDateTime\n"
                    + "       min:'2010-08-12T13:22:01'\n"
                    + "       max:'2010-09-12T13:22:01'\n"
                    + "   }\n"
                    + "}\n"
                },
                {tag: "With collection filter",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerModel {\n"
                    + "   id:organizerModelId\n"
                    + "   filter:CollectionFilter{\n"
                    + "       id:filter\n"
                    + "       ids:['1234', '456', '90']\n"
                    + "   }\n"
                    + "}\n"
                },
                {tag: "With intersection filter",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerModel {\n"
                    + "   id:organizerModelId\n"
                    + "   filter:IntersectionFilter {\n"
                    + "       id:filter\n"
                    + "       filters:[\n"
                    + "           DetailFilter{\n"
                    + "               id:filter1\n"
                    + "               field:EventTime.FieldStartDateTime\n"
                    + "               value:'2010-08-12T13:22:01'\n"
                    + "           },\n"
                    + "           DetailRangeFilter{\n"
                    + "               id:filter2\n"
                    + "               field:EventTime.FieldStartDateTime\n"
                    + "               min:'2010-08-12T13:22:01'\n"
                    + "               max:'2010-09-12T13:22:01'\n"
                    + "           }\n"
                    + "      ]\n"
                    + "   }\n"
                    + "}\n"
                },
                {tag: "With fetchHint",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerModel {\n"
                    + "    id:organizerModelId\n"
                    + "    fetchHint:FetchHint {\n"
                    + "        id:hint\n"
                    + "        optimizationHints:FetchHint.AllRequired\n"
                    + "    }\n"
                    + "}\n"
                },

                // Organizer Items
                {tag: "Base organizer item",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerItem {\n"
                    + "}\n"
                },
                {tag: "Base organizer item: only id",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerItem {\n"
                    + "    id:organizerItem\n"
                    + "}\n"
                },
                {tag: "Base organizer item: Valuetype properties",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerItem {\n"
                    + "    id:organizerItem\n"
                    + "    displayLabel:'test item'\n"
                    + "    description:'item description'\n"
                    + "    guid:'1112232133'\n"
                    + "}\n"
                },

                {tag: "Base organizer item: default property",
                 code: "import QtOrganizer 5.0\n"
                    + "OrganizerItem {\n"
                    + "    id:organizerItem\n"
                    + "    DisplayLabel {\n"
                    + "        label:'test item'\n"
                    + "    }\n"
                    + "    Description {\n"
                    + "        description:'item description'\n"
                    + "    }\n"
                    + "    Guid{\n"
                    + "        guid:'111223213'\n"
                    + "    }\n"
                    + "}\n"
                },

                //Event
                {tag: "Organizer event",
                 code: "import QtOrganizer 5.0\n"
                    + "Event {\n"
                    + "}\n"
                },
                /*{tag: "Organizer event:Valuetype properties",
                 code: "import QtOrganizer 5.0 \n"
                    + "Event {\n"
                    + "    id:organizerEvent\n"
                    + "    displayLabel:'meeting'\n"
                    + "    startDateTime:'2010-08-12T13:00:00'\n"
                    + "    endDateTime:'2010-08-12T15:00:00'\n"
                    + "    allDay:false\n"
                    + "    location:'office'\n"
                    + "    Location {\n"
                    + "        label:'53 Brandl st'\n"
                    + "        latitude:-27.579570\n"
                    + "        longitude:153.10031\n"
                    + "    }\n"
                    + "    priority:Priority.Low\n"
                    + "    recurrence.recurrenceRules:[\n"
                    + "        RecurrenceRule {\n"
                    + "        }\n"
                    + "    ]\n"
                    + "    recurrence.recurrenceDates:[]\n"
                    + "    recurrence.exceptionDates:[]\n"
                    + "}\n"
                },*/
                /*
                {tag: "",
                 code: ""
                },
                */

        ]
    }

    function test_componentCreation(data)
    {
        try{
            var obj = Qt.createQmlObject(data.code, myRectangle, "dynamicSnippet1");
            verify(obj != undefined, "Unable to load script for " + data.tag);
            obj.destroy();
            console.log("Completed test on '" + data.tag + "'")
        }
        catch (errorObject)  {
            console.log("For code " + data.code + " Error was seen is " +  errorObject );
        }

    }

    function checkDetails(events)
    {
        var testDataEvents = test_addEvent_data()[0].events
        var foundEvent = false
        var testDataEvent = undefined
        for (var index = 0; index < testDataEvents.length; index++){
            testDataEvent = testDataEvents[index]
            foundEvent = false
            console.log("Checking event " + testDataEvent.subject)
            for (var index2 = 0; index2 < events.length; index2++){
                var actualEvent = events[index2];
                if (testDataEvent.subject == actualEvent.description){
                    foundEvent = true
                    compare(actualEvent.type, testDataEvent.type)
                    compare(actualEvent.startDateTime.toString(), testDataEvent.startDateTime.toString())
                    compare(actualEvent.endDateTime.toString(), testDataEvent.endDateTime.toString())
                    if (testDataEvent.repeat != undefined){
                        verify(actualEvent.recurrence != undefined, "Expected recurrance Element to be present for event")
                        verify(actualEvent.recurrence.recurrenceRules.length == 1, "Expected there to be one RecurranceRule")
                        var recurranceRule = actualEvent.recurrence.recurrenceRules[0] // first rule only
                        switch (event.repeat){
                        case RecurrenceRule.Daily:
                        case RecurrenceRule.Weekly:
                        case RecurrenceRule.Monthly:
                        case RecurrenceRule.Yearly:
                            compare(recurranceRule.frequency, RecurrenceRule.Weekly)
                            for (var dayIndex=0; dayIndex < testDataEvent.repeatDays; dayIndex++){
                                verify(recurranceRule.daysOfWeek.indexOf(testDataEvent.repeatDays[dayIndex]) != -1, "Expected event to recurrence on day " + testDataEvent.repeatDays[dayIndex])
                            }
                            compare(recurranceRule.limit.toString(), testDataEvent.limit.toString())
                        break
                        default:
                            if (event.repeat != RecurrenceRule.Invalid)
                                console.log("Unsupported repeat for Event actual:" + actualEvent.reoccurance + " expected:" + testDataEvent.repeat);
                        }
                    }
                    break
                }
            }
            //verify(foundEvent, "Did not find event " + testDataEvent.subject)
        }
        console.log("Done checking Event")
    }

    // test data is handled by addEvent.qml function addEvents()
    function test_addEvent_data() {
        return [
            {tag: "Event set 1",
                events:[
                    {tag: "Event 1",
                     type: Type.Event,
                     subject: "Event 1",
                     description: "starts 2010-12-09 8AM finishes 5PM",
                     startDateTime: new Date(2010, 12, 9, 8, 0),
                     endDateTime: new Date(2010, 12, 9, 17, 0),
                    },
                    {tag: "Event 2",
                     type: Type.Event,
                     subject: "Event 2",
                     description: "starts 2010-12-08 8AM finishes 1PM",
                     startDateTime: new Date(2010, 12, 8, 8, 0),
                     endDateTime: new Date(2010, 12, 8, 13, 0),
                    },
                    {tag: "Event 3",
                     type: Type.Event,
                     subject: "Event 3",
                     description: "starts a month from 2010-12-08 at 11AM finish at 2PM",
                     startDateTime: new Date(2010, 12, 8, 11, 0),
                     endDateTime: new Date(2010, 12, 8, 14, 0),
                    },
                    {tag: "Event 4",
                     type: Type.Event,
                     subject: "Event 4",
                     description: "starts after Event 3 and finishes 4PM",
                     startDateTime: new Date(2010, 12, 8, 14, 0),
                     endDateTime: new Date(2010, 12, 8, 16, 0),
                    },
                    {tag: "Event 5",
                     type: Type.Event,
                     subject: "Event 5",
                     description: "starts after Event 4 and finishes 5PM",
                     startDateTime: new Date(2010, 12, 8, 16, 0),
                     endDateTime: new Date(2010, 12, 8, 17, 0),
                    },
                    {tag: "Event 6",
                     type: Type.Event,
                     subject: "Event 6",
                     description: "starts 2010-12-10 at 11AM finishing 1PM, repeating for 4 weeks",
                     startDateTime: new Date(2010, 12, 10, 11, 0),
                     endDateTime: new Date(2010, 12, 10, 13, 0),
                     repeat: RecurrenceRule.Weekly,
                     repeatDays: [Qt.Friday],
                     repeatCount: 4
                    },
                ]
            }
        ]
    }

    function test_addEvent(data)
    {
        var component = Qt.createComponent("addEvent.qml")
        var obj = component.createObject(top)
        if (obj == undefined)
            console.log("Unable to load component from " + name +  " error is ", component.errorString())
        verify(obj != undefined, 'Unable to load component ' + name)
        obj.addEvents(data.events)
        var items = obj.testEvents()
        checkDetails(items)
        if (items.length == 0)
            console.log("No records added")
        obj.destroy()
        component.destroy()
    }

    function test_organizermodel_error_data() {
        return [
            {tag: "memory backend", managerToBeTested: "memory"},
            {tag: "jsondb backend", managerToBeTested: "jsondb"}
        ]
    }

    function test_organizermodel_error(data) {
        var spyWaitDelay = 200;
        var organizerChangedSpy = utility.create_testobject("import QtTest 1.0; SignalSpy {}", modelTests);
        // Create and check that backend for the tests is available
        var organizerModel = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "OrganizerModel {\n"
            + "  manager: '" + data.managerToBeTested + "'\n"
            + "}\n", modelTests);
        organizerChangedSpy.target = organizerModel;
        organizerChangedSpy.signalName = "modelChanged";
        organizerChangedSpy.wait();
        organizerModel.removeCollection(organizerModel.defaultCollection().collectionId);
        wait(spyWaitDelay);// how to utilise SignalSpy to check signal is _not_ emitted?
        compare(organizerModel.error, "PermissionsError");
    }

    function test_organizermodel_fetchitems_data() {
        return [
            {tag: "memory backend", managerToBeTested: "memory"},
            {tag: "jsondb backend", managerToBeTested: "jsondb"}
        ]
    }

    function test_organizermodel_fetchitems(data) {
        var organizerModel = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "OrganizerModel {\n"
            + "  manager: '" + data.managerToBeTested + "'\n"
            + "}\n", modelTests);
        wait(500);

        compare(organizerModel.fetchItems([]), -1)

        var spy = Qt.createQmlObject( "import QtTest 1.0 \nSignalSpy {}", modelTests);
        spy.target = organizerModel;
        spy.signalName = "itemsFetched";

        verify(organizerModel.fetchItems(["invalid-id"]) >= 0)
        spy.wait()
        compare(spy.count, 1)
    }

    function test_organizermodel_containsitems_data() {
        return [
            {tag: "memory backend", managerToBeTested: "memory"},
            {tag: "jsondb backend", managerToBeTested: "jsondb"}
        ]
    }

    function test_organizermodel_containsitems(data) {
        var organizerModel = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "OrganizerModel {\n"
            + "  manager: '" + data.managerToBeTested + "'\n"
            + "  startPeriod: new Date(2011, 12, 8, 14, 0)\n"
            + "  endPeriod: new Date(2011, 12, 8, 16, 0)\n"
            + "}\n", modelTests);
        utility.init(organizerModel)
        utility.waitModelChange()
        utility.empty_calendar()

        var event1 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 13, 55)\n"
            + "  endDateTime: new Date(2011, 12, 8, 14, 07)\n"
            + "}\n", modelTests);

        var event2 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 14, 11)\n"
            + "  endDateTime: new Date(2011, 12, 8, 14, 15)\n"
            + "}\n", modelTests);

        var event3 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 14, 25, 0)\n"
            + "}\n", modelTests);

        var event4 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  endDateTime: new Date(2011, 12, 8, 14, 45)\n"
            + "}\n", modelTests);

        var event5 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 14, 55)\n"
            + "  endDateTime: new Date(2011, 12, 8, 15, 05)\n"
            + "}\n", modelTests);

        organizerModel.saveItem(event1);
        utility.waitModelChange()
        organizerModel.saveItem(event2);
        utility.waitModelChange()
        organizerModel.saveItem(event3);
        utility.waitModelChange()
        organizerModel.saveItem(event4);
        utility.waitModelChange()
        organizerModel.saveItem(event5);
        utility.waitModelChange()
        compare(organizerModel.items.length, 5);

        var containsItems = organizerModel.containsItems(new Date(2011, 12, 8, 14, 0), new Date(2011, 12, 8, 16, 0), 600);
        compare(containsItems.length, 12);
        compare(containsItems[0], true);
        compare(containsItems[1], true);
        compare(containsItems[2], true);
        compare(containsItems[3], false);
        compare(containsItems[4], true);
        compare(containsItems[5], true);
        compare(containsItems[6], true);
        compare(containsItems[7], false);
        compare(containsItems[8], false);
        compare(containsItems[9], false);
        compare(containsItems[10], false);
        compare(containsItems[11], false);
    }

    function test_organizermodel_containsitems2_data() {
        return [
            {tag: "memory backend", managerToBeTested: "memory"},
            {tag: "jsondb backend", managerToBeTested: "jsondb"}
        ]
    }

    function test_organizermodel_containsitems2(data) {
        var organizerModel = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "OrganizerModel {\n"
            + "  manager: '" + data.managerToBeTested + "'\n"
            + "  startPeriod: new Date(2011, 12, 7)\n"
            + "  endPeriod: new Date(2011, 12, 9)\n"
            + "}\n", modelTests);
        utility.init(organizerModel)
        utility.waitModelChange()
        utility.empty_calendar()

        var event00 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 7, 11)\n"
            + "  endDateTime: new Date(2011, 12, 8, 0, 30)\n"
            + "}\n", modelTests);

        var event0 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 1)\n"
            + "}\n", modelTests);

        var event1 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 3)\n"
            + "  endDateTime: new Date(2011, 12, 8, 3, 30)\n"
            + "}\n", modelTests);

        var event2 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 5)\n"
            + "  endDateTime: new Date(2011, 12, 8, 6)\n"
            + "}\n", modelTests);


        var event3 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 8)\n"
            + "  endDateTime: new Date(2011, 12, 8, 10)\n"
            + "}\n", modelTests);

        var event4 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 11, 30)\n"
            + "  endDateTime: new Date(2011, 12, 8, 12)\n"
            + "}\n", modelTests);

        var event5 = utility.create_testobject("import QtQuick 2.0\n"
            + "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 8, 13)\n"
            + "  endDateTime: new Date(2011, 12, 8, 13, 30)\n"
            + "}\n", modelTests);

        compare(organizerModel.items.length, 0);
        organizerModel.saveItem(event00);
        utility.waitModelChange()
        organizerModel.saveItem(event0);
        utility.waitModelChange()
        organizerModel.saveItem(event1);
        utility.waitModelChange()
        organizerModel.saveItem(event2);
        utility.waitModelChange()
        organizerModel.saveItem(event3);
        utility.waitModelChange()
        organizerModel.saveItem(event4);
        utility.waitModelChange()
        organizerModel.saveItem(event5);
        utility.waitModelChange()
        compare(organizerModel.items.length, 7);

        var containsItems = organizerModel.containsItems(new Date(2011, 12, 8), new Date(2011, 12, 8, 13), 3600);

        compare(containsItems.length, 13);
        compare(containsItems[0], true);
        compare(containsItems[1], true);
        compare(containsItems[2], false);
        compare(containsItems[3], true);
        compare(containsItems[4], false);
        compare(containsItems[5], true);
        compare(containsItems[6], false);
        compare(containsItems[7], false);
        compare(containsItems[8], true);
        compare(containsItems[9], true);
        compare(containsItems[10], false);
        compare(containsItems[11], true);
        compare(containsItems[12], false);
    }

    function modelChangedSignalTestItems() {
        return [
            // events
            "import QtOrganizer 5.0 \n"
            + "   Event {\n"
            + "   startDateTime:'2011-10-25'\n"
            + "   allDay: false\n"
            + "   }",
            "import QtOrganizer 5.0 \n"
            + "   Event {\n"
            + "   startDateTime:'2011-10-26'\n"
            + "   allDay: true\n"
            + "   }"
        ]
    }

    // to test various usecases for modelChanged-signal
    function test_modelChangedSignal() {
        var managerlist = utility.getManagerList();
        if (managerlist.length < 0) {
            console.log("No manager to test");
            return;
        }
        for (var i = 0; i < managerlist.length; i ++) {

            var filter = Qt.createQmlObject("import QtOrganizer 5.0; DetailFilter{}", modelTests)
            filter.detail = Detail.EventTime
            filter.field = EventTime.FieldAllDay
            filter.value = true

            var model = Qt.createQmlObject(
                    "import QtOrganizer 5.0;"
                    + "OrganizerModel {"
                    + "   manager: \"qtorganizer:" + managerlist[i] + ":id=qml\";"
                    + "   startPeriod:'2009-01-01';"
                    + "   endPeriod:'2012-12-31';"
                    + "   autoUpdate:true; }"
                    , modelTests);
            console.log("## Testing plugin: " + managerlist[i]);
            var modelChangedSpy = Qt.createQmlObject("import QtTest 1.0; SignalSpy{}", modelTests)
            modelChangedSpy.target = model
            modelChangedSpy.signalName = "modelChanged"

            // during initialisation only one modelChanged allowed
            wait(signalWaitTime);
            compare(modelChangedSpy.count, 1)

            // prepare for rest of cases
            utility.init(model)
            utility.empty_calendar()
            utility.addItemsToModel(modelChangedSignalTestItems(), modelTests)
            compare(model.itemCount, 2)

            // after filterchange only one modelChanged allowed
            modelChangedSpy.clear()
            model.filter = filter
            wait(signalWaitTime);
            compare(modelChangedSpy.count, 1)
            compare(model.itemCount, 1)

            // after manual update only one modelChanged allowed
            model.autoUpdate = false
            modelChangedSpy.clear()
            model.filter = null
            model.update()
            wait(signalWaitTime);
            compare(modelChangedSpy.count, 1)
            compare(model.itemCount, 2)
            utility.empty_calendar()
        }
    }

    function test_updateMethods() {
        var managerlist = utility.getManagerList();
        if (managerlist.length < 0) {
            console.log("No manager to test");
            return;
        }
        for (var i = 0; i < managerlist.length; i ++) {
            var organizerModel = Qt.createQmlObject(
                    "import QtOrganizer 5.0;"
                    + "OrganizerModel {"
                    + "   manager: '" + managerlist[i] + "'\n"
                    + "   startPeriod:'2009-01-01'\n"
                    + "   endPeriod:'2012-12-31'\n"
                    + "}"
                    , modelTests);
            console.log("## Testing plugin: " + managerlist[i]);

            utility.init(organizerModel);
            utility.waitModelChange();
            utility.empty_calendar();

            var event1 = utility.create_testobject(
                "import QtOrganizer 5.0\n"
                + "Event {\n"
                + "  startDateTime: new Date(2011, 12, 7, 11)\n"
                + "  endDateTime: new Date(2011, 12, 8, 0, 30)\n"
                + "}\n", modelTests);
            var event2 = utility.create_testobject(
                "import QtOrganizer 5.0\n"
                + "Event {\n"
                + "  startDateTime: new Date(2011, 13, 7, 11)\n"
                + "  endDateTime: new Date(2011, 13, 8, 0, 30)\n"
                + "}\n", modelTests);

            var collection1 = utility.create_testobject("import QtQuick 2.0 \n"
              + "import QtOrganizer 5.0\n"
              + "Collection {\n"
              + "id: coll1\n"
              + "}\n", modelTests);

            var collection2 = utility.create_testobject("import QtQuick 2.0 \n"
              + "import QtOrganizer 5.0\n"
              + "Collection {\n"
              + "id: coll1\n"
              + "}\n", modelTests);

            var modelChangedSpy = Qt.createQmlObject("import QtTest 1.0; SignalSpy{}", modelTests)
            modelChangedSpy.target = organizerModel
            modelChangedSpy.signalName = "modelChanged"
            var collectionsChangedSpy = Qt.createQmlObject("import QtTest 1.0; SignalSpy{}", modelTests)
            collectionsChangedSpy.target = organizerModel
            collectionsChangedSpy.signalName = "collectionsChanged"

            organizerModel.autoUpdate = false;

            // starting point
            compare(organizerModel.items.length, 0);
            compare(organizerModel.collections.length, 1);

            // updateItems() - should update only items
            organizerModel.saveItem(event1);
            organizerModel.saveCollection(collection1);
            wait(signalWaitTime)
            compare(modelChangedSpy.count, 0)
            compare(collectionsChangedSpy.count, 0)
            compare(organizerModel.items.length, 0)
            compare(organizerModel.collections.length, 1)
            organizerModel.updateItems();
            modelChangedSpy.wait(signalWaitTime)
            compare(modelChangedSpy.count, 1)
            compare(collectionsChangedSpy.count, 0)
            compare(organizerModel.items.length, 1)//+1
            compare(organizerModel.collections.length, 1)// collection change not visible, only default collection visible

            // updateCollections() - should update only collections
            modelChangedSpy.clear();
            collectionsChangedSpy.clear();
            organizerModel.saveItem(event2);
            // - there is saved unseen collection from updateItems()-test
            wait(signalWaitTime)
            compare(modelChangedSpy.count, 0)
            compare(collectionsChangedSpy.count, 0)
            organizerModel.updateCollections();
            collectionsChangedSpy.wait(signalWaitTime)
            compare(modelChangedSpy.count, 0)
            compare(collectionsChangedSpy.count, 1)
            compare(organizerModel.items.length, 1)// event2 not visible, only event1 saved in updateItems()-test visible
            compare(organizerModel.collections.length, 2)//+1

            // update() - should update both
            modelChangedSpy.clear();
            collectionsChangedSpy.clear();
            // - there is saved unseen item from updateCollections()-test
            organizerModel.saveCollection(collection2);
            wait(signalWaitTime)
            compare(modelChangedSpy.count, 0)
            compare(collectionsChangedSpy.count, 0)
            organizerModel.update();
            modelChangedSpy.wait(signalWaitTime)
            compare(modelChangedSpy.count, 1)
            compare(collectionsChangedSpy.count, 1)
            compare(organizerModel.items.length, 2)//+1
            compare(organizerModel.collections.length, 3)//+1

            modelChangedSpy.destroy();
            collectionsChangedSpy.destroy();
            organizerModel.destroy();
        }
    }

    function test_updateMethodsStartWithAutoupdateFalse() {

        var organizerModel = Qt.createQmlObject(
                "import QtOrganizer 5.0;"
                + "OrganizerModel {"
                + "   manager: 'jsondb'\n"
                + "   startPeriod:'2009-01-01'\n"
                + "   endPeriod:'2012-12-31'\n"
                + "   autoUpdate: false\n"
                + "}"
                , modelTests);
        console.log("## Testing only jsondb-plugin");

        var modelChangedSpy = Qt.createQmlObject("import QtTest 1.0; SignalSpy{}", modelTests)
        modelChangedSpy.target = organizerModel
        modelChangedSpy.signalName = "modelChanged"
        var collectionsChangedSpy = Qt.createQmlObject("import QtTest 1.0; SignalSpy{}", modelTests)
        collectionsChangedSpy.target = organizerModel
        collectionsChangedSpy.signalName = "collectionsChanged"

        // After test_updateMethods()-test there should be
        // 2 items and 2 collections (+ default collection)
        // on the jsondb. They're just not visible, since
        // autoUpdate is false.
        compare(organizerModel.items.length, 0);
        compare(organizerModel.collections.length, 0);

        // Check we see still only collections after updating collections
        organizerModel.updateCollections();
        collectionsChangedSpy.wait(signalWaitTime)
        compare(organizerModel.items.length, 0);
        compare(organizerModel.collections.length, 3);// 2 + default collection

        // Save there item with other collection than default collection
        var event = utility.create_testobject(
            "import QtOrganizer 5.0\n"
            + "Event {\n"
            + "  startDateTime: new Date(2011, 12, 7, 11)\n"
            + "  endDateTime: new Date(2011, 12, 8, 0, 30)\n"
            + "}\n", modelTests);
        for (var i = 0; i < organizerModel.collections.length; ++i) {
            var collId = organizerModel.collections[i].collectionId;
            if (collId != organizerModel.defaultCollection().collectionId) {
                event.collectionId = collId;
            }
        }
        organizerModel.saveItem(event);
        wait(signalWaitTime)

        // Create collection filter and check that only the item with that collection is visible
        var collectionFilter = Qt.createQmlObject("import QtOrganizer 5.0;CollectionFilter{}", modelTests);
        collectionFilter.ids = [event.collectionId];
        organizerModel.filter = collectionFilter;
        organizerModel.updateItems();
        modelChangedSpy.wait(signalWaitTime)
        compare(organizerModel.items.length, 1);// 1 with that collection

        // Lastly check we get everything if filter is reset
        organizerModel.filter = null;
        organizerModel.updateItems();
        modelChangedSpy.wait(signalWaitTime)
        compare(organizerModel.items.length, 3); // all items

        // cleanup
        utility.init(organizerModel);
        utility.empty_calendar();

        collectionFilter.destroy();
        modelChangedSpy.destroy();
        collectionsChangedSpy.destroy();
        organizerModel.destroy();
    }
}

