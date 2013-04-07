function NormalizedToolObject(tool, value, radius) {
    var toolScale = d3.scale.linear()
        .domain(K.ToolBounds[tool])
        .range([K.MinRadius*radius,radius]);

    return {
        value: toolScale(value),
        color: K.ToolColors[K.ToolIndex[tool]],
        theta: K.ToolIndex[tool] * K.ArcTheta + K.AngleOffset
    };
}

function FormattedToolData(toolValues, radius) {
    return [
        NormalizedToolObject("contact",  toolValues["contact"],  radius),
        NormalizedToolObject("power",    toolValues["power"],    radius),
        NormalizedToolObject("fielding", toolValues["fielding"], radius),
        NormalizedToolObject("throwing", toolValues["throwing"], radius),
        NormalizedToolObject("speed",    toolValues["speed"],    radius)
    ];
}

function DrawToolsChart(where, geometry, tools) {
    var radius = Math.min(geometry.width, geometry.height) / 2.0;
    var toolData = FormattedToolData(tools, radius);
    var center = {
        x: geometry.width / 2,
        y: geometry.height / 2};

    var svg = d3.select('#' + where)
        .append("svg")
        .attr("width", geometry.width)
        .attr("height", geometry.height)
        .append("g")
        .attr("transform", "rotate(" + -360/5/2 + "," + center.x + "," + center.y + ")")
        .attr("transform", "translate(" + center.x + "," + center.y + ")");

    svg.selectAll(".arc")
        .data(toolData)
        .enter().append("path")
        .attr("class", "tool-arc")

    var g = svg.selectAll(".tool-arc")
        .attr("d", d3.svg.arc()
            .innerRadius(0)
            .outerRadius(function(d) {return Math.max(0,d.value);})
            .startAngle(function(d) {return d.theta;})
            .endAngle(function(d) {return d.theta + K.ArcTheta;}))
        .attr("fill", function(d) {return d.color;})
        .attr("stroke","black")
        .attr("stroke-width", "0.5px")
        .attr("transition", "transform", "ro")
        .on("mouseover", function(d) {
            div.transition()
                .duration(200)
                .style("opacity", .9);
            div .html("hellow world!")
                .style("left", (d3.event.pageX) + "px")
                .style("top", (d3.event.pageY - 28) + "px");
        })
        .on("mouseout", function(d) {
            div.transition()
                .duration(500)
                .style("opacity", 0);
        });
}