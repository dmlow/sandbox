// name some vars
var currentTeam = teams[0],
    currentSeason = 2012,
    globalData;

// create a form
var f = $('<form>')
    .attr('id','team-and-season-form')
    .change(function() {

    });
$('#parameters').append(f);

// teams drop down
var teamDropdown = $('<select>')
    .attr('id','team-dropdown')
    .attr('onChange','currentTeam = teams[this.selectedIndex]; updatePlot();');
f.append('Team: ')
f.append(teamDropdown);
teams.forEach(function(d) {
    var teamOption = $('<option>')
            .attr('value', d.shortName)
            .text(d.name);
    teamDropdown.append(teamOption);
});
f.append('<br>');

// season drop down
var yearDropdown = $('<select>')
    .attr('id', 'year-dropdown')
    .attr('onChange', 'currentSeason = this.value; updatePlot();');
f.append('Season: ')
f.append(yearDropdown);
for (var year = 2012; year >= 2002; year--) {
    var yearOption = $('<option>')
        .attr('value', year)
        .text(year);
    yearDropdown.append(yearOption);
}

//meh, let's just do it with flat text!
function showTeams() {
    var leagues = ['National', 'American'],
        divisions = ['West', 'Central', 'East'];

    leagues.forEach(function (league) {
        var leagueDiv = $('<div>')
            .attr('id', league + '-' + 'League')
            .addClass('league')
            .append($('<h1>').text(league + ' League'))
            .css('clear','left');
        $('#parameters').append(leagueDiv);

        divisions.forEach(function (division) {
            var divisionDiv = $('<div>')
                .attr('id', league + '-League-' + division)
                .css('position', 'relative')
                .css('width', '20%')
                .css('float', 'left')
                .addClass('division')
                .append($('<h2>').text(division));
            leagueDiv.append(divisionDiv);

            var theseTeams = teams.filter(function(d) { return (d.league == league) && (d.division == division)});

            theseTeams.forEach(function (team) {
                var t = $('<button>')
                    .addClass('team')
                    .addClass('deselected')
                    .text(team.name)
                    .css('font-size', '20pt')
                    .css('border-width','0px')
                    .css('background', team.color1)
                    .css('color', team.color2)
                    .css('display', 'block')
                    // .css('padding','5px 0px 5px 0px')
                    .css('overflow', 'visible')
                    .css('position','relative')
                    .click(function(teamButton) {
                        for (var i=0; i < teams.length; i++) {
                            if (teams[i].name == team.name) {
                                currentTeam = teams[i];
                                break;
                            }
                        }
                    });

                divisionDiv.append(t);
            });

        });

    });

/*
    teams.forEach(function (team) {
       var t = $('<span>')
           .addClass('deselected')
           .text(team.name)
               .css('font-size', '30px')
               .css('background', team.color1)
               .css('color', team.color2)
               .css('display', 'block')
               .css('margin','5px 0px 5px 0px')
               .css('width','200px')
           .click(function(teamButton) {
               for (var i=0; i < teams.length; i++) {
                   if (teams[i].name == team.name) {
                       currentTeam = teams[i];
                       break;
                   }
               }
           });
        $('#parameters').append(t);
    });
*/
}

// showTeams();

function grabData() {
    d3.csv('data/data.csv', function(data) {

        globalData = data;
        plotData();
    });
}



function plotData() {
    var geometry = {
        'width': 500,
        'height': 300,
        'margin': 10
    };

    var currentData = globalData.filter(function(d) {
        return (d['Team'] == currentTeam.name && +d['Season'] == currentSeason);;
    });

    currentData.sort(function(a, b) { return +a['BABIP'] - +b['BABIP'];});

    var x = d3.scale.ordinal()
        .domain(d3.range(currentData.length))
        .rangeRoundBands([geometry.margin, geometry.width + geometry.margin])
    ;

    var y = d3.scale.linear()
        .rangeRound([geometry.margin, geometry.height + geometry.margin])
        .domain([0,1]);

    var svg = d3.select('#plots')
        .append('svg')
        .attr('id', 'babip-svg')
        .attr('width', geometry.width)
        .attr('height', geometry.height);

    var g = svg.append('g');

    var bars = g.selectAll('.bar')
        .data(currentData)
        .enter()
        .append('rect')
        .attr('x', function(d, i) { return x(i);})
        .attr('width', x.rangeBand())
        .attr('height', function(d) {return y(+d['BABIP']);})
        .attr('y', function(d) {return y(1 - +d['BABIP'])})
        .attr('stroke', 'none')
        .attr('fill', currentTeam.color1);
}

function updatePlot() {
    var geometry = {
        'width': 500,
        'height': 300,
        'margin': 10
    };

    var currentData = globalData.filter(function(d) {
        return (d['Team'] == currentTeam.name && +d['Season'] == currentSeason);;
    });

    currentData.sort(function(a, b) { return +a['BABIP'] - +b['BABIP'];});


    var x = d3.scale.ordinal()
            .domain(d3.range(currentData.length))
            .rangeRoundBands([geometry.margin, geometry.width + geometry.margin])
        ;

    var y = d3.scale.linear()
        .rangeRound([geometry.margin, geometry.height + geometry.margin])
        .domain([0,1]);

    var svg = d3.select('#babip-svg');

    bars = svg.select('g')
        .selectAll('.bar')
        .data(currentData)
        .enter()
            .append('rect')
            .attr('x', function(d, i) { return x(i);})
            .attr('width', x.rangeBand())
            .attr('height', function(d) {return y(+d['BABIP']);})
            .attr('y', function(d) {return y(1 - +d['BABIP'])})
            .attr('stroke', 'none')
            .attr('fill', currentTeam.color1)
        .exit()
            .remove();

}

grabData();