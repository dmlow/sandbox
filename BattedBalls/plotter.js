//d3.csv('data/data.csv', function(data) {
//    var svg = d3.selectAll('#plots')
//        .append('svg')
//            .attr('width', 500)
//            .attr('height', 500)
//            .attr('background', 'white')
//        .append('g').selectAll('circle')
//        .data(data).enter()
//        .append('circle')
//            .attr('cx', function(d) { return +d["BABIP"]*500;})
//            .attr('cy', function(d) { return +d["Zone (pfx)"]*5;})
//            .attr('r', 2)
//            .attr('stroke','black')
//            .attr('fill', 'red');
//});

//d3.csv('data/data.csv', function(data) {
//    var currentData = data.filter(function(d) {
//        return (data['Team'] == currentTeam.name && +data.Season == currentSeason)
//    });
//
//    var svg = d3.selectAll('#plots')
//        .append('svg')
//        .attr('width', 500)
//        .attr('height', 500)
//        .append('g')
//        .data(currentData).selectAll('circ')
//        .attr('cx', function(d) {return +d['LD'] * 5;})
//        .attr('cy', function(d) {return +d['FB'] * 5;})
//        .attr('r', 2)
//        .attr('stroke', currentTeam.color1)
//        .attr('fill', currentTeam.color2)
//});