var fs = require('fs');
var times = JSON.parse(fs.readFileSync('times.json'));

var output = {};

function saveTime(type, time, newtime) {
	if (!(time in output)) output[time] = {};
	output[time][type] = newtime;
}

function printTable(times) {
	console.log('| Time       | Vertical   | Horizontal | Rotated    | Reversed   |');
	console.log('| ---------- | ---------- | ---------- | ---------- | ---------- |');
	times.forEach((time) => {
		if (time && 'time' in time) {
			console.log('| ' + time.time + '      | ' + (time.vertical || '     ') + '      | ' + (time.horizontal || '     ') + '      | ' + (time.rotated || '     ') + '      | ' + (time.reversed || '     ') + '      |');
		}
	});
}

function istwelvehour(timestring) {
	if (timestring) {
		var hour = parseInt(timestring.slice(0, 2));
		var minute = parseInt(timestring.slice(3, 5));
		if (hour >= 1 && hour <= 12 && minute >= 00 && minute <= 59) return true;
	}
}

function buildTransposedTimes(type) {
	Object.entries(times[type].hours).forEach(([hour, newminute]) => {
		Object.entries(times[type].minutes).forEach(([minute, newhour]) => {
			saveTime(type, [hour, minute].join(":"), [newhour, newminute].join(":"));
		});
	});
}

function buildTimes(type) {
	Object.entries(times[type].hours).forEach(([hour, newhour]) => {
		Object.entries(times[type].minutes).forEach(([minute, newminute]) => {
			saveTime(type, [hour, minute].join(":"), [newhour, newminute].join(":"));
		});
	});
}

buildTimes('vertical');
['horizontal', 'rotated', 'reversed'].forEach((type) => {
	buildTransposedTimes(type);
});

var ordered = [];

Object.keys(output).sort().forEach(function(key) {
	ordered.push(Object.assign({time: key}, output[key]));
});

var twelvehour = ordered.map(time => {
	if (!istwelvehour(time.time)) return;
	['vertical', 'horizontal', 'rotated', 'reversed'].forEach((type) => {
		if (!istwelvehour(time[type])) delete time[type];
	});
	if (Object.keys(time).length > 1) return time;
});

console.log('### 24 Hour Clock\n');
printTable(ordered);
console.log('### 12 Hour Clock\n');
printTable(twelvehour);
