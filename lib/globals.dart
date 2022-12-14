library my_prj.globals;

import 'package:intl/intl.dart';

bool isGlobal = false;
bool isTimeOn = false;
bool isTimeOff = false;

int userTime = 10;

DateTime startTime = DateFormat("mm:ss").parse("00:00");
DateTime endTime = DateFormat("mm:ss").parse("01:01");

Duration userTimeLeft = endTime.difference(startTime);
