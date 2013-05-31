$(document).ready(function() {
    var w = 640;
    var h = 480;
    var data = [[ 72,  83],
                [ 94, 163],
                [194, 294],
                [371,  57],
                [422, 391]
            ];


    var svg = d3.select("body").append("svg")
        .attr("width", w)
        .attr("height", h);
    svg.selectAll("circle")
        .data(data)
        .enter()
        .append("circle")
        .attr("cx", function(d) {return d[0];})
        .attr("cy", function(d) {return d[1];})
        .attr("r", 5);
});