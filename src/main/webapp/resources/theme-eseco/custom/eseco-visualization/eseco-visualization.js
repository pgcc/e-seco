/**
 * E-SECO VISUALIZATION JS
 */

/*********************************************/
/* GRAPH                                     */
/*********************************************/

function drawGraph(data){
    // Call function to draw the Radar chart
    if(data.constructor === Object){
        GraphChart.draw(data);

    }else if(typeof data === "string"){
        d3.json(data, function (error, data) {
            if (error) throw error;
            GraphChart.draw(data);
        });
    }
}

var GraphChart = {
    draw: function (data) {


    }
};



/*********************************************/
/* TREEMAP                                   */
/*********************************************/
function drawTreemap(datFn01) {

    // Call function to draw the Radar chart
    if(datFn01.constructor === Object){
        TreemapChart.draw(datFn01);

    }else if(typeof datFn01 === "string"){
        d3.json(datFn01, function (error, data) {
            if (error) throw error;
            TreemapChart.draw(data);
        });
    }
}

function hovered(hover) {
    return function (d) {
        d3.selectAll(d.ancestors().map(function (d) {
            return d.node;
        }))
            .classed("node--hover", hover)
            .select("rect")
            .attr("width", function (d) {
                return d.x1 - d.x0 - hover;
            })
            .attr("height", function (d) {
                return d.y1 - d.y0 - hover;
            });
    };
}

var TreemapChart = {
    draw: function (data) {
        var paddingAllowance = 2;

        var container = d3.select("#chart").html("");

        var svg = container.append("svg");
        var width = 800;
        var height = 500;


        svg.attr("width", width).attr("height", height);

        var color = d3.scaleOrdinal(d3.schemeCategory20c);

        var treemap = d3.treemap()
            .size([width, height])
            .paddingOuter(3)
            .paddingTop(19)
            .paddingInner(1)
            .round(true);



        var root = d3.hierarchy(data)
            .eachBefore(function (d) {
                d.data.id = (d.parent ? d.parent.data.id + "." : "") + d.data.name;
            })
            .sum(function (d) {
                return d.size;
            })
            .sort(function (a, b) {
                return b.height - a.height || b.value - a.value;
            });

        var node = root;
        treemap(root);


        var cell = svg
            .selectAll(".node")
            .data(root.descendants())
            .enter().append("g")
            .attr("transform", function (d) {
                return "translate(" + d.x0 + "," + d.y0 + ")";
            })
            .attr("class", "node")
            .each(function (d) {
                d.node = this;
            })
            .on("mouseover", hovered(true))
            .on("mouseout", hovered(false));

        cell.append("rect")
            .attr("id", function (d) {
                return "rect-" + d.id;
            })
            .attr("width", function (d) {
                return d.x1 - d.x0;
            })
            .attr("height", function (d) {
                return d.y1 - d.y0;
            })
            .style("fill", function (d) {
                return color(d.depth);
            });

        cell.append("foreignObject")
            .attr("class", "foreignObject")
            .attr("width", function (d) {
                return d.x1 - d.x0 - paddingAllowance;
            })
            .attr("height", function (d) {
                return d.y1 - d.y0 - paddingAllowance;
            })
            .append("xhtml:div")
            .attr("class", "treemap-block-header")
            .append("p")
            .text(function (d) {
                //console.log(d.data)
                return d.data.name;
            })
            .attr("text-anchor", "middle")


    }
};


/*********************************************/
/* RADAR                                     */
/*********************************************/
function drawRadar(data, targetId) {
    /*
     var svg = d3.select("svg");
     svg.html("");
     */

    var width = 300,
        height = 300;

    // Config for the Radar chart
    var config = {
        w: width,
        h: height,
        maxValue: 10,
        levels: 10,
        ExtraWidthX: 300
    };

    // Call function to draw the Radar chart
    if(data.constructor === Array){
        RadarChart.draw("#"+targetId, data, config);

    }else if(typeof data === "string"){
        d3.json(data, function (error, data) {
            if (error) throw error;
            RadarChart.draw("#"+targetId, data, config);
        });
    }

    var svg = d3.select('body')
        .selectAll('svg')
        .append('svg')
        .attr("width", width)
        .attr("height", height);
}

var RadarChart = {
    draw: function (id, d, options) {
        var cfg = {
            radius: 5,
            w: 600,
            h: 600,
            factor: 1,
            factorLegend: .85,
            levels: 3,
            maxValue: 0,
            radians: 2 * Math.PI,
            opacityArea: 0.5,
            ToRight: 5,
            TranslateX: 80,
            TranslateY: 30,
            ExtraWidthX: 100,
            ExtraWidthY: 100,
            color: d3.scaleOrdinal(d3.schemeCategory10)
        };

        if ('undefined' !== typeof options) {
            for (var i in options) {
                if ('undefined' !== typeof options[i]) {
                    cfg[i] = options[i];
                }
            }
        }


        var allAxis = (d[0].map(function (i, j) {
            return i.area
        }));
        var total = allAxis.length;
        var radius = cfg.factor * Math.min(cfg.w / 2, cfg.h / 2);
        var Format = d3.format('%');
        d3.select(id).select("svg").remove();


        var container = d3.select(id).html("");

        var g = container
            .append("svg")
            .attr("width", cfg.w + cfg.ExtraWidthX)
            .attr("height", cfg.h + cfg.ExtraWidthY)
            .append("g")
            .attr("transform", "translate(" + cfg.TranslateX + "," + cfg.TranslateY + ")");

        var tooltip;

        //Circular segments
        for (var j = 0; j < cfg.levels; j++) {
            var levelFactor = cfg.factor * radius * ((j + 1) / cfg.levels);
            g.selectAll(".levels")
                .data(allAxis)
                .enter()
                .append("svg:line")
                .attr("x1", function (d, i) {
                    return levelFactor * (1 - cfg.factor * Math.sin(i * cfg.radians / total));
                })
                .attr("y1", function (d, i) {
                    return levelFactor * (1 - cfg.factor * Math.cos(i * cfg.radians / total));
                })
                .attr("x2", function (d, i) {
                    return levelFactor * (1 - cfg.factor * Math.sin((i + 1) * cfg.radians / total));
                })
                .attr("y2", function (d, i) {
                    return levelFactor * (1 - cfg.factor * Math.cos((i + 1) * cfg.radians / total));
                })
                .attr("class", "line")
                .style("stroke", "grey")
                .style("stroke-opacity", "0.75")
                .style("stroke-width", "0.3px")
                .attr("transform", "translate(" + (cfg.w / 2 - levelFactor) + ", " + (cfg.h / 2 - levelFactor) + ")");
        }

        //Text indicating at what % each level is
        for (var j = 0; j < cfg.levels; j++) {
            var levelFactor = cfg.factor * radius * ((j + 1) / cfg.levels);
            g.selectAll(".levels")
                .data([1]) //dummy data
                .enter()
                .append("svg:text")
                .attr("x", function (d) {
                    return levelFactor * (1 - cfg.factor * Math.sin(0));
                })
                .attr("y", function (d) {
                    return levelFactor * (1 - cfg.factor * Math.cos(0));
                })
                .attr("class", "legend")
                .style("font-family", "sans-serif")
                .style("font-size", "10px")
                .attr("transform", "translate(" + (cfg.w / 2 - levelFactor + cfg.ToRight) + ", " + (cfg.h / 2 - levelFactor) + ")")
                .attr("fill", "#737373")
                .text((j + 1) * cfg.maxValue / cfg.levels);
        }

        series = 0;

        var axis = g.selectAll(".axis")
            .data(allAxis)
            .enter()
            .append("g")
            .attr("class", "axis");

        axis.append("line")
            .attr("x1", cfg.w / 2)
            .attr("y1", cfg.h / 2)
            .attr("x2", function (d, i) {
                return cfg.w / 2 * (1 - cfg.factor * Math.sin(i * cfg.radians / total));
            })
            .attr("y2", function (d, i) {
                return cfg.h / 2 * (1 - cfg.factor * Math.cos(i * cfg.radians / total));
            })
            .attr("class", "line")
            .style("stroke", "grey")
            .style("stroke-width", "1px");

        axis.append("text")
            .attr("class", "legend")
            .text(function (d) {
                return d
            })
            .style("font-family", "sans-serif")
            .style("font-size", "11px")
            .attr("text-anchor", "middle")
            .attr("dy", "1.5em")
            .attr("transform", function (d, i) {
                return "translate(0, -10)"
            })
            .attr("x", function (d, i) {
                return cfg.w / 2 * (1 - cfg.factorLegend * Math.sin(i * cfg.radians / total)) - 60 * Math.sin(i * cfg.radians / total);
            })
            .attr("y", function (d, i) {
                return cfg.h / 2 * (1 - Math.cos(i * cfg.radians / total)) - 20 * Math.cos(i * cfg.radians / total);
            });


        d.forEach(function (y, x) {
            dataValues = [];
            g.selectAll(".nodes")
                .data(y, function (j, i) {
                    dataValues.push([
                        cfg.w / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.sin(i * cfg.radians / total)),
                        cfg.h / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.cos(i * cfg.radians / total))
                    ]);
                });
            dataValues.push(dataValues[0]);
            g.selectAll(".area")
                .data([dataValues])
                .enter()
                .append("polygon")
                .attr("class", "radar-chart-serie" + series)
                .style("stroke-width", "2px")
                .style("stroke", cfg.color(series))
                .attr("points", function (d) {
                    var str = "";
                    for (var pti = 0; pti < d.length; pti++) {
                        str = str + d[pti][0] + "," + d[pti][1] + " ";
                    }
                    return str;
                })
                .style("fill", function (j, i) {
                    return cfg.color(series)
                })
                .style("fill-opacity", cfg.opacityArea)
                .on('mouseover', function (d) {
                    z = "polygon." + d3.select(this).attr("class");
                    g.selectAll("polygon")
                        .transition(200)
                        .style("fill-opacity", 0.1);
                    g.selectAll(z)
                        .transition(200)
                        .style("fill-opacity", .7);
                })
                .on('mouseout', function () {
                    g.selectAll("polygon")
                        .transition(200)
                        .style("fill-opacity", cfg.opacityArea);
                });
            series++;
        });
        series = 0;


        var tooltip = d3.select("body").append("div").attr("class", "toolTip");
        d.forEach(function (y, x) {
            g.selectAll(".nodes")
                .data(y).enter()
                .append("svg:circle")
                .attr("class", "radar-chart-serie" + series)
                .attr('r', cfg.radius)
                .attr("alt", function (j) {
                    return Math.max(j.value, 0)
                })
                .attr("cx", function (j, i) {
                    dataValues.push([
                        cfg.w / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.sin(i * cfg.radians / total)),
                        cfg.h / 2 * (1 - (parseFloat(Math.max(j.value, 0)) / cfg.maxValue) * cfg.factor * Math.cos(i * cfg.radians / total))
                    ]);
                    return cfg.w / 2 * (1 - (Math.max(j.value, 0) / cfg.maxValue) * cfg.factor * Math.sin(i * cfg.radians / total));
                })
                .attr("cy", function (j, i) {
                    return cfg.h / 2 * (1 - (Math.max(j.value, 0) / cfg.maxValue) * cfg.factor * Math.cos(i * cfg.radians / total));
                })
                .attr("data-id", function (j) {
                    return j.area
                })
                .style("fill", "#fff")
                .style("stroke-width", "2px")
                .style("stroke", cfg.color(series)).style("fill-opacity", .9)
                .on('mouseover', function (d) {
                    console.log(d.area)
                    tooltip
                        .style("left", d3.event.pageX - 40 + "px")
                        .style("top", d3.event.pageY - 80 + "px")
                        .style("display", "inline-block")
                        .html((d.area) + "<br><span>" + (d.value) + "</span>");
                })
                .on("mouseout", function (d) {
                    tooltip.style("display", "none");
                });

            series++;
        });
    }
};