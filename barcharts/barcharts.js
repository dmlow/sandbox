/**
 * Created with JetBrains WebStorm.
 * User: fireplacetv
 * Date: 4/20/13
 * Time: 2:54 PM
 * To change this template use File | Settings | File Templates.
 */

$(document).ready(function() {
    var dataset = [];

    d3.csv("data/POP-UNRATE-PAYEMS.csv", function(d) {
        var idx = 20;
        var datapoints = 10;
        dataset = d.slice(idx, idx + datapoints);
        drawChart(dataset);
    });
});

function drawChart(dataset) {
    // parameters
    var width = 500,
        height = 480;

    var xScale = d3.scale
        .ordinal()
        .domain(d3.range(dataset.length))
        .rangeRoundBands([0, width], 0.5);

    var popScale = d3.scale
        .linear()
        .domain([0, d3.max(dataset, function(d) { return d.POP; })])
        .range([0, height]);

    var unrateScale = d3.scale
        .linear()
        .domain([0, d3.max(dataset, function(d) { return d.UNRATE; })])
        .range([0, height]);

    var payemsScale = d3.scale
        .linear()
        .domain([0, d3.max(dataset, function(d) { return d.PAYEMS; })])
        .range([0, height]);

    // add our SVG
    var svg = d3.select("#chart-area")
        .append("svg")
        .attr("width", width)
        .attr("height", height);

    // UNRATE
    svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .classed("bar", true)
        .classed("unrate", true)
        .attr("x", function(d, i) {
            return xScale(i);
        })
        .attr("y", function(d, i) {
            return height - unrateScale(d.UNRATE);
        })
        .attr("width", xScale.rangeBand())
        .attr("height", function(d, i) {
            return unrateScale(d.UNRATE);
        })
        .attr("fill", "#0000ff");

};