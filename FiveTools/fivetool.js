// this is where I put all the logic for generating the five tool nightingale charts

function NormalizedToolObject(tool, value, radius) {
    var toolBoundMin = Math.min(K.ToolBounds[tool][0],K.ToolBounds[tool][1]);
//    var lowerToolBound = K.ToolBounds[tool][0] - toolBoundMin;
//    var upperToolBound = Math.sqrt(Math.abs(K.ToolBounds[tool][1] - toolBoundMin));
//    var toolScale = d3.scale.linear()
//        .domain(lowerToolBound, upperToolBound)
//        .range([K.MinRadius*radius,0.95*radius]);
    var toolScale = d3.scale.linear()
        .domain(K.ToolBounds[tool])
        .range([K.MinRadius * radius, radius]);
    var sqrtScale = d3.scale.linear()
        .domain([Math.sqrt(K.MinRadius * radius) / Math.PI, Math.sqrt(radius) / Math.PI])
        .range([K.MinRadius * radius, radius])

    return {
//        normedValue: toolScale(value),
        normedValue: sqrtScale(Math.sqrt(toolScale(value)) / Math.PI),
        value: value,
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
        .attr("class", "tool-chart")
        .append("g")
        .attr("transform", "rotate(" + -360/5/2 + "," + center.x + "," + center.y + ")")
        .attr("transform", "translate(" + center.x + "," + center.y + ")");

    svg.selectAll(".arc")
        .data(toolData)
        .enter().append("path")
        .attr("class", "tool-arc");

    var g = svg.selectAll(".tool-arc")
        // draw the pie slices
        .attr("d", d3.svg.arc()
            .innerRadius(0)
            .outerRadius(function(d) {return d.normedValue;})
            .startAngle(function(d) {return d.theta;})
            .endAngle(function(d) {return d.theta + K.ArcTheta;}))
        .attr("fill", function(d) {return d.color;});

}