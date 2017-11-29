/**
 * E-SECO VISUALIZATION JS
 */

/*********************************************/
/* GRAPH                                     */
/*********************************************/
function drawGraph(data, target, width) {
    // Call function to draw the Radar chart
    if (data.constructor === Object) {
        GraphChart.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error) throw error;
            GraphChart.draw(data, target, width);
        });
    }
}

var GraphChart = {
    draw: function (data, target, width) {

        if (!window.d3) {
            var d3 = d3version3;
        }

        // get the data
        var nodecolor = d3.scale.category20();

        var nodes = {};

        // Compute the distinct nodes from the links.
        var links = data.links;

        var height = 400;

        var force = d3.layout.force()
            .nodes(data.nodes)
            .links(links)
            .size([width, height])
            .linkDistance(function (d) {
                return 1 / d.value * 125;
            })
            .charge(-250)
            .on("tick", tick)
            .start();

        // Set the range
        var v = d3.scale.linear().range([0, 100]);

        // Scale the range of the data
        v.domain([0, d3.max(links, function (d) {
            return d.value;
        })]);

        // asign a type per value to encode opacity
        links.forEach(function (link) {
            if (v(link.value) <= 25) {
                link.type = "twofive";
            } else if (v(link.value) <= 50 && v(link.value) > 25) {
                link.type = "fivezero";
            } else if (v(link.value) <= 75 && v(link.value) > 50) {
                link.type = "sevenfive";
            } else if (v(link.value) <= 100 && v(link.value) > 75) {
                link.type = "onezerozero";
            }
        });

        var container = d3.select(target).html("");

        var svg = container.append("svg")
            .attr("width", width)
            .attr("height", height);

        // build the arrow.
        svg.append("svg:defs").selectAll("marker")
            .data(["end"])      // Different link/path types can be defined here
            .enter().append("svg:marker")    // This section adds in the arrows
            .attr("id", String)
            .attr("viewBox", "0 -5 10 10")
            .attr("refX", 15)
            .attr("refY", -1.5)
            .attr("markerWidth", 6)
            .attr("markerHeight", 6)
            .attr("orient", "auto")
            .append("svg:path")
            .attr("d", "M0,-5L10,0L0,5");

        // add the links and the arrows
        var path = svg.append("svg:g").selectAll("path")
            .data(force.links())
            .enter().append("svg:path")
            .attr("class", function (d) {
                return "link " + d.type;
            })
            .attr("marker-end", "url(#end)");

        // define the nodes
        var node = svg.selectAll(".node")
            .data(force.nodes())
            .enter().append("g")
            .attr("class", "node")
            .on("click", click)
            .on("dblclick", dblclick)
            .call(force.drag);

        // add the nodes
        node.append("circle")
            .attr("r", 5)
            .style("fill", function (d) {
                return nodecolor(d.group);
            });

        // add the text
        node.append("text")
            .attr("x", 12)
            .attr("dy", ".35em")
            .text(function (d) {
                return d.name;
            });

        // add the curvy lines
        function tick() {
            path.attr("d", function (d) {
                var dx = d.target.x - d.source.x,
                    dy = d.target.y - d.source.y,
                    dr = Math.sqrt(dx * dx + dy * dy);
                return "M" +
                    d.source.x + "," +
                    d.source.y + "A" +
                    dr + "," + dr + " 0 0,1 " +
                    d.target.x + "," +
                    d.target.y;
            });

            node
                .attr("transform", function (d) {
                    return "translate(" + d.x + "," + d.y + ")";
                });
        }

        // action to take on mouse click
        function click() {
            d3.select(this).select("text").transition()
                .duration(750)
                .attr("x", 22)
                .style("fill", "steelblue")
                .style("stroke", "lightsteelblue")
                .style("stroke-width", ".5px");
            d3.select(this).select("circle").transition()
                .duration(750)
                .attr("r", 16)
                .style("fill", function (d) {
                    return nodecolor(d.group);
                });
        }

        // action to take on mouse double click
        function dblclick() {
            d3.select(this).select("circle").transition()
                .duration(750)
                .attr("r", 6)
                .style("fill", function (d) {
                    return nodecolor(d.group);
                });
            d3.select(this).select("text").transition()
                .duration(750)
                .attr("x", 12)
                .style("stroke", "none")
                .style("fill", "black")
                .style("stroke", "none")
                .style("font", "10px sans-serif");
        }
    }
};


/*********************************************/
/* TREEMAP                                   */
/*********************************************/
function drawTreemap(datFn01, target, width) {

    // Call function to draw the chart
    if (datFn01.constructor === Object) {
        TreemapChart.draw(datFn01, target, width);

    } else if (typeof datFn01 === "string") {
        d3.json(datFn01, function (error, data) {
            if (error) throw error;
            TreemapChart.draw(data, target, width);
        });
    }
}

function hovered(hover) {
    return function (d) {
        if (!window.d3) {
            var d3 = d3version4;
        }
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
    draw: function (data, target, width) {
        if (!window.d3) {
            var d3 = d3version4;
        }

        var paddingAllowance = 2;

        var container = d3.select(target).html("");

        var svg = container.append("svg");
        var width = width;
        var height = 250;


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
    if (data.constructor === Array) {
        RadarChart.draw("#" + targetId, data, config);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error) throw error;
            RadarChart.draw("#" + targetId, data, config);
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


/*********************************************/
/* PARALLEL COORDINATES                      */
/*********************************************/
function drawParallelCoordinates(data, targetId) {
    var width = 800,
        height = 500;

    var options = {};

    // Call function to draw the Radar chart
    if (data.constructor === Array) {
        ParallelCoordinatesChart.draw(data, targetId, options);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error) throw error;
            ParallelCoordinatesChart.draw(data, targetId, options);
        });
    }

    var svg = d3.select('body')
        .selectAll('svg')
        .append('svg')
        .attr("width", width)
        .attr("height", height);
}

var ParallelCoordinatesChart = {
    draw: function (data, targetId, options) {
        var margin = {top: 50, right: 160, bottom: 20, left: 120},
            width = 1000,
            height = 340;

        var devicePixelRatio = window.devicePixelRatio || 1;

        var color = d3.scale.ordinal()
            .range(["#5DA5B3", "#D58323", "#DD6CA7", "#54AF52", "#8C92E8", "#E15E5A", "#725D82", "#776327", "#50AB84", "#954D56", "#AB9C27", "#517C3F", "#9D5130", "#357468", "#5E9ACF", "#C47DCB", "#7D9E33", "#DB7F85", "#BA89AD", "#4C6C86", "#B59248", "#D8597D", "#944F7E", "#D67D4B", "#8F86C2"]);

        var types = {
            "Number": {
                key: "Number",
                coerce: function (d) {
                    return +d;
                },
                extent: d3.extent,
                within: function (d, extent) {
                    return extent[0] <= d && d <= extent[1];
                },
                defaultScale: d3.scale.linear().range([height, 0])
            },
            "String": {
                key: "String",
                coerce: String,
                extent: function (data) {
                    return data.sort();
                },
                within: function (d, extent, dim) {
                    return extent[0] <= dim.scale(d) && dim.scale(d) <= extent[1];
                },
                defaultScale: d3.scale.ordinal().rangePoints([0, height])
            },
            "Date": {
                key: "Date",
                coerce: function (d) {
                    return new Date(d);
                },
                extent: d3.extent,
                within: function (d, extent) {
                    return extent[0] <= d && d <= extent[1];
                },
                defaultScale: d3.time.scale().range([0, height])
            }
        };

        var dimensions = [
            {
                key: "researcher",
                description: "Researcher",
                type: types["String"],
                axis: d3.svg.axis().orient("left")
            }, {
                key: "date",
                description: "Date",
                type: types["String"],
                axis: d3.svg.axis().orient("left")
            }, {
                key: "approved",
                description: "Approved?",
                type: types["String"],
                axis: d3.svg.axis().orient("left")
            }, {
                key: "documentation",
                description: "Documentation",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "ease_of_use",
                description: "Ease of Use",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "reliability",
                description: "Reliability",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "performance",
                description: "Performance",
                type: types["Number"],
                domain: [0, 10]
            }, {
                key: "availability",
                description: "Availability",
                type: types["Number"],
                domain: [0, 10]
            }
        ];

        var xscale = d3.scale.ordinal()
            .domain(d3.range(dimensions.length))
            .rangePoints([0, width]);

        var yAxis = d3.svg.axis()
            .orient("left");

        var container = d3.select("#" + targetId).append("div")
            .attr("class", "parcoords")
            .style("width", width + margin.left + margin.right + "px")
            .style("height", height + margin.top + margin.bottom + "px");

        var svg = container.append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        var canvas = container.append("canvas")
            .attr("width", (width + 1) * devicePixelRatio)
            .attr("height", (height + 1) * devicePixelRatio)
            .style("width", (width + 1) + "px")
            .style("height", (height + 1) + "px")
            .style("margin-top", margin.top + "px")
            .style("margin-left", margin.left + "px");

        var ctx = canvas.node().getContext("2d");
        ctx.globalCompositeOperation = 'darken';
        ctx.globalAlpha = 0.15;
        ctx.lineWidth = 1.5;
        ctx.scale(devicePixelRatio, devicePixelRatio);

        var axes = svg.selectAll(".axis")
            .data(dimensions)
            .enter().append("g")
            .attr("class", function (d) {
                return "axis " + d.key;
            })
            .attr("transform", function (d, i) {
                return "translate(" + xscale(i) + ")";
            });


        // type/dimension default setting happens here
        dimensions.forEach(function (dim) {
            if (!("domain" in dim)) {
                // detect domain using dimension type's extent function
                dim.domain = d3.functor(dim.type.extent)(data.map(function (d) {
                    return d[dim.key];
                }));

                // TODO - this line only works because the data encodes data with integers
                // Sorting/comparing should be defined at the type/dimension level
                dim.domain.sort(function (a, b) {
                    return a - b;
                });
            }
            if (!("scale" in dim)) {
                // use type's default scale for dimension
                dim.scale = dim.type.defaultScale.copy();
            }
            dim.scale.domain(dim.domain);
        });

        var render = renderQueue(draw).rate(30);

        ctx.clearRect(0, 0, width + 1, height + 1);
        ctx.globalAlpha = d3.min([0.75 / Math.pow(data.length, 0.3), 1]);
        render(data);

        axes.append("g")
            .each(function (d) {
                var renderAxis = "axis" in d
                    ? d.axis.scale(d.scale)  // custom axis
                    : yAxis.scale(d.scale);  // default axis
                d3.select(this).call(renderAxis);
            })
            .append("text")
            .attr("class", "title")
            .attr("text-anchor", "start")
            .text(function (d) {
                return "description" in d ? d.description : d.key;
            });

        // Add and store a brush for each axis.
        axes.append("g")
            .attr("class", "brush")
            .each(function (d) {
                d3.select(this).call(d.brush = d3.svg.brush()
                    .y(d.scale)
                    .on("brushstart", brushstart)
                    .on("brush", brush));
            })
            .selectAll("rect")
            .attr("x", -8)
            .attr("width", 16);

        d3.selectAll(".axis.food_group .tick text")
            .style("fill", color);


        function project(d) {
            return dimensions.map(function (p, i) {
                if (d[p.key] === null) return null;
                return [xscale(i), p.scale(d[p.key])];
            });
        };

        function draw(d) {
            ctx.strokeStyle = color(d.food_group);
            ctx.beginPath();
            var coords = project(d);
            coords.forEach(function (p, i) {
                // this tricky bit avoids rendering null values as 0
                if (p === null) {
                    // this bit renders horizontal lines on the previous/next
                    // dimensions, so that sandwiched null values are visible
                    if (i > 0) {
                        var prev = coords[i - 1];
                        if (prev !== null) {
                            ctx.moveTo(prev[0], prev[1]);
                            ctx.lineTo(prev[0] + 6, prev[1]);
                        }
                    }
                    if (i < coords.length - 1) {
                        var next = coords[i + 1];
                        if (next !== null) {
                            ctx.moveTo(next[0] - 6, next[1]);
                        }
                    }
                    return;
                }

                if (i == 0) {
                    ctx.moveTo(p[0], p[1]);
                    return;
                }

                ctx.lineTo(p[0], p[1]);
            });
            ctx.stroke();
        }

        function brushstart() {
            d3.event.sourceEvent.stopPropagation();
        }

        // Handles a brush event, toggling the display of foreground lines.
        function brush() {
            var actives = dimensions.filter(function (p) {
                    return !p.brush.empty();
                }),
                extents = actives.map(function (p) {
                    return p.brush.extent();
                });

            var selected = data.filter(function (d) {
                if (actives.every(function (dim, i) {
                        // test if point is within extents for each active brush
                        return dim.type.within(d[dim.key], extents[i], dim);
                    })) {
                    return true;
                }
            });

            ctx.clearRect(0, 0, width + 1, height + 1);
            ctx.globalAlpha = d3.min([0.75 / Math.pow(selected.length, 0.3), 1]);
            render(selected);
        }

    }
};

var renderQueue = (function (func) {
    var _queue = [],                  // data to be rendered
        _rate = 1000,                 // number of calls per frame
        _invalidate = function () {
        },  // invalidate last render queue
        _clear = function () {
        };       // clearing function

    var rq = function (data) {
        if (data) rq.data(data);
        _invalidate();
        _clear();
        rq.render();
    };

    rq.render = function () {
        var valid = true;
        _invalidate = rq.invalidate = function () {
            valid = false;
        };

        function doFrame() {
            if (!valid) return true;
            var chunk = _queue.splice(0, _rate);
            chunk.map(func);
            timer_frame(doFrame);
        }

        doFrame();
    };

    rq.data = function (data) {
        _invalidate();
        _queue = data.slice(0);   // creates a copy of the data
        return rq;
    };

    rq.add = function (data) {
        _queue = _queue.concat(data);
    };

    rq.rate = function (value) {
        if (!arguments.length) return _rate;
        _rate = value;
        return rq;
    };

    rq.remaining = function () {
        return _queue.length;
    };

    // clear the canvas
    rq.clear = function (func) {
        if (!arguments.length) {
            _clear();
            return rq;
        }
        _clear = func;
        return rq;
    };

    rq.invalidate = _invalidate;

    var timer_frame = window.requestAnimationFrame
        || window.webkitRequestAnimationFrame
        || window.mozRequestAnimationFrame
        || window.oRequestAnimationFrame
        || window.msRequestAnimationFrame
        || function (callback) {
            setTimeout(callback, 17);
        };

    return rq;
});


/*********************************************/
/* WORD COUNT                                */
/*********************************************/
function drawWordCount(data, target, width) {

    // Call function to draw the chart
    if (data.constructor === Array) {
        WordCountChart.draw(data, target, width);

    } else if (typeof data === "string") {
        d3.json(data, function (error, data) {
            if (error) throw error;
            WordCountChart.draw(data, target, width);
        });
    }
}

var WordCountChart = {
    draw: function (data, target, width) {
        var color = d3.scale.linear()
            .domain([0, 1, 2, 3, 4, 5, 6, 10, 15, 20, 100])
            .range(["#ddd", "#ccc", "#bbb", "#aaa", "#999", "#888", "#777", "#666", "#555", "#444", "#333", "#222"]);

        d3.layout.cloud().size([(width - 50), 200])
            .words(data)
            .rotate(0)
            .fontSize(function (d) {
                return d.size;
            })
            .on("end", draw)
            .start();

        function draw(words) {
            d3.select(target).append("svg")
                .attr("width", width)
                .attr("height", 250)
                .attr("class", "wordcloud")
                .append("g")
                // without the transform, words words would get cutoff to the left and top, they would
                // appear outside of the SVG area
                .attr("transform", "translate(" + ((width-50) / 2) + ",125)")
                .selectAll("text")
                .data(words)
                .enter().append("text")
                .style("font-size", function (d) {
                    return d.size + "px";
                })
                .style("fill", function (d, i) {
                    return color(i);
                })
                .attr("transform", function (d) {
                    return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                })
                .text(function (d) {
                    return d.text;
                });
        }

    }
};

// Word cloud layout by Jason Davies, http://www.jasondavies.com/word-cloud/
// Algorithm due to Jonathan Feinberg, http://static.mrfeinberg.com/bv_ch03.pdf
(function (exports) {
    function cloud() {
        var size = [256, 256],
            text = cloudText,
            font = cloudFont,
            fontSize = cloudFontSize,
            fontStyle = cloudFontNormal,
            fontWeight = cloudFontNormal,
            rotate = cloudRotate,
            padding = cloudPadding,
            spiral = archimedeanSpiral,
            words = [],
            timeInterval = Infinity,
            event = d3.dispatch("word", "end"),
            timer = null,
            cloud = {};

        cloud.start = function () {
            var board = zeroArray((size[0] >> 5) * size[1]),
                bounds = null,
                n = words.length,
                i = -1,
                tags = [],
                data = words.map(function (d, i) {
                    d.text = text.call(this, d, i);
                    d.font = font.call(this, d, i);
                    d.style = fontStyle.call(this, d, i);
                    d.weight = fontWeight.call(this, d, i);
                    d.rotate = rotate.call(this, d, i);
                    d.size = ~~fontSize.call(this, d, i);
                    d.padding = padding.call(this, d, i);
                    return d;
                }).sort(function (a, b) {
                    return b.size - a.size;
                });

            if (timer) clearInterval(timer);
            timer = setInterval(step, 0);
            step();

            return cloud;

            function step() {
                var start = +new Date,
                    d;
                while (+new Date - start < timeInterval && ++i < n && timer) {
                    d = data[i];
                    d.x = (size[0] * (Math.random() + .5)) >> 1;
                    d.y = (size[1] * (Math.random() + .5)) >> 1;
                    cloudSprite(d, data, i);
                    if (d.hasText && place(board, d, bounds)) {
                        tags.push(d);
                        event.word(d);
                        if (bounds) cloudBounds(bounds, d);
                        else bounds = [{x: d.x + d.x0, y: d.y + d.y0}, {x: d.x + d.x1, y: d.y + d.y1}];
                        // Temporary hack
                        d.x -= size[0] >> 1;
                        d.y -= size[1] >> 1;
                    }
                }
                if (i >= n) {
                    cloud.stop();
                    event.end(tags, bounds);
                }
            }
        }

        cloud.stop = function () {
            if (timer) {
                clearInterval(timer);
                timer = null;
            }
            return cloud;
        };

        cloud.timeInterval = function (x) {
            if (!arguments.length) return timeInterval;
            timeInterval = x == null ? Infinity : x;
            return cloud;
        };

        function place(board, tag, bounds) {
            var perimeter = [{x: 0, y: 0}, {x: size[0], y: size[1]}],
                startX = tag.x,
                startY = tag.y,
                maxDelta = Math.sqrt(size[0] * size[0] + size[1] * size[1]),
                s = spiral(size),
                dt = Math.random() < .5 ? 1 : -1,
                t = -dt,
                dxdy,
                dx,
                dy;

            while (dxdy = s(t += dt)) {
                dx = ~~dxdy[0];
                dy = ~~dxdy[1];

                if (Math.min(dx, dy) > maxDelta) break;

                tag.x = startX + dx;
                tag.y = startY + dy;

                if (tag.x + tag.x0 < 0 || tag.y + tag.y0 < 0 ||
                    tag.x + tag.x1 > size[0] || tag.y + tag.y1 > size[1]) continue;
                // TODO only check for collisions within current bounds.
                if (!bounds || !cloudCollide(tag, board, size[0])) {
                    if (!bounds || collideRects(tag, bounds)) {
                        var sprite = tag.sprite,
                            w = tag.width >> 5,
                            sw = size[0] >> 5,
                            lx = tag.x - (w << 4),
                            sx = lx & 0x7f,
                            msx = 32 - sx,
                            h = tag.y1 - tag.y0,
                            x = (tag.y + tag.y0) * sw + (lx >> 5),
                            last;
                        for (var j = 0; j < h; j++) {
                            last = 0;
                            for (var i = 0; i <= w; i++) {
                                board[x + i] |= (last << msx) | (i < w ? (last = sprite[j * w + i]) >>> sx : 0);
                            }
                            x += sw;
                        }
                        delete tag.sprite;
                        return true;
                    }
                }
            }
            return false;
        }

        cloud.words = function (x) {
            if (!arguments.length) return words;
            words = x;
            return cloud;
        };

        cloud.size = function (x) {
            if (!arguments.length) return size;
            size = [+x[0], +x[1]];
            return cloud;
        };

        cloud.font = function (x) {
            if (!arguments.length) return font;
            font = d3.functor(x);
            return cloud;
        };

        cloud.fontStyle = function (x) {
            if (!arguments.length) return fontStyle;
            fontStyle = d3.functor(x);
            return cloud;
        };

        cloud.fontWeight = function (x) {
            if (!arguments.length) return fontWeight;
            fontWeight = d3.functor(x);
            return cloud;
        };

        cloud.rotate = function (x) {
            if (!arguments.length) return rotate;
            rotate = d3.functor(x);
            return cloud;
        };

        cloud.text = function (x) {
            if (!arguments.length) return text;
            text = d3.functor(x);
            return cloud;
        };

        cloud.spiral = function (x) {
            if (!arguments.length) return spiral;
            spiral = spirals[x + ""] || x;
            return cloud;
        };

        cloud.fontSize = function (x) {
            if (!arguments.length) return fontSize;
            fontSize = d3.functor(x);
            return cloud;
        };

        cloud.padding = function (x) {
            if (!arguments.length) return padding;
            padding = d3.functor(x);
            return cloud;
        };

        return d3.rebind(cloud, event, "on");
    }

    function cloudText(d) {
        return d.text;
    }

    function cloudFont() {
        return "serif";
    }

    function cloudFontNormal() {
        return "normal";
    }

    function cloudFontSize(d) {
        return Math.sqrt(d.value);
    }

    function cloudRotate() {
        return (~~(Math.random() * 6) - 3) * 30;
    }

    function cloudPadding() {
        return 1;
    }

    // Fetches a monochrome sprite bitmap for the specified text.
    // Load in batches for speed.
    function cloudSprite(d, data, di) {
        if (d.sprite) return;
        c.clearRect(0, 0, (cw << 5) / ratio, ch / ratio);
        var x = 0,
            y = 0,
            maxh = 0,
            n = data.length;
        --di;
        while (++di < n) {
            d = data[di];
            c.save();
            c.font = d.style + " " + d.weight + " " + ~~((d.size + 1) / ratio) + "px " + d.font;
            var w = c.measureText(d.text + "m").width * ratio,
                h = d.size << 1;
            if (d.rotate) {
                var sr = Math.sin(d.rotate * cloudRadians),
                    cr = Math.cos(d.rotate * cloudRadians),
                    wcr = w * cr,
                    wsr = w * sr,
                    hcr = h * cr,
                    hsr = h * sr;
                w = (Math.max(Math.abs(wcr + hsr), Math.abs(wcr - hsr)) + 0x1f) >> 5 << 5;
                h = ~~Math.max(Math.abs(wsr + hcr), Math.abs(wsr - hcr));
            } else {
                w = (w + 0x1f) >> 5 << 5;
            }
            if (h > maxh) maxh = h;
            if (x + w >= (cw << 5)) {
                x = 0;
                y += maxh;
                maxh = 0;
            }
            if (y + h >= ch) break;
            c.translate((x + (w >> 1)) / ratio, (y + (h >> 1)) / ratio);
            if (d.rotate) c.rotate(d.rotate * cloudRadians);
            c.fillText(d.text, 0, 0);
            if (d.padding) c.lineWidth = 2 * d.padding, c.strokeText(d.text, 0, 0);
            c.restore();
            d.width = w;
            d.height = h;
            d.xoff = x;
            d.yoff = y;
            d.x1 = w >> 1;
            d.y1 = h >> 1;
            d.x0 = -d.x1;
            d.y0 = -d.y1;
            d.hasText = true;
            x += w;
        }
        var pixels = c.getImageData(0, 0, (cw << 5) / ratio, ch / ratio).data,
            sprite = [];
        while (--di >= 0) {
            d = data[di];
            if (!d.hasText) continue;
            var w = d.width,
                w32 = w >> 5,
                h = d.y1 - d.y0;
            // Zero the buffer
            for (var i = 0; i < h * w32; i++) sprite[i] = 0;
            x = d.xoff;
            if (x == null) return;
            y = d.yoff;
            var seen = 0,
                seenRow = -1;
            for (var j = 0; j < h; j++) {
                for (var i = 0; i < w; i++) {
                    var k = w32 * j + (i >> 5),
                        m = pixels[((y + j) * (cw << 5) + (x + i)) << 2] ? 1 << (31 - (i % 32)) : 0;
                    sprite[k] |= m;
                    seen |= m;
                }
                if (seen) seenRow = j;
                else {
                    d.y0++;
                    h--;
                    j--;
                    y++;
                }
            }
            d.y1 = d.y0 + seenRow;
            d.sprite = sprite.slice(0, (d.y1 - d.y0) * w32);
        }
    }

    // Use mask-based collision detection.
    function cloudCollide(tag, board, sw) {
        sw >>= 5;
        var sprite = tag.sprite,
            w = tag.width >> 5,
            lx = tag.x - (w << 4),
            sx = lx & 0x7f,
            msx = 32 - sx,
            h = tag.y1 - tag.y0,
            x = (tag.y + tag.y0) * sw + (lx >> 5),
            last;
        for (var j = 0; j < h; j++) {
            last = 0;
            for (var i = 0; i <= w; i++) {
                if (((last << msx) | (i < w ? (last = sprite[j * w + i]) >>> sx : 0))
                    & board[x + i]) return true;
            }
            x += sw;
        }
        return false;
    }

    function cloudBounds(bounds, d) {
        var b0 = bounds[0],
            b1 = bounds[1];
        if (d.x + d.x0 < b0.x) b0.x = d.x + d.x0;
        if (d.y + d.y0 < b0.y) b0.y = d.y + d.y0;
        if (d.x + d.x1 > b1.x) b1.x = d.x + d.x1;
        if (d.y + d.y1 > b1.y) b1.y = d.y + d.y1;
    }

    function collideRects(a, b) {
        return a.x + a.x1 > b[0].x && a.x + a.x0 < b[1].x && a.y + a.y1 > b[0].y && a.y + a.y0 < b[1].y;
    }

    function archimedeanSpiral(size) {
        var e = size[0] / size[1];
        return function (t) {
            return [e * (t *= .1) * Math.cos(t), t * Math.sin(t)];
        };
    }

    function rectangularSpiral(size) {
        var dy = 4,
            dx = dy * size[0] / size[1],
            x = 0,
            y = 0;
        return function (t) {
            var sign = t < 0 ? -1 : 1;
            // See triangular numbers: T_n = n * (n + 1) / 2.
            switch ((Math.sqrt(1 + 4 * sign * t) - sign) & 3) {
                case 0:
                    x += dx;
                    break;
                case 1:
                    y += dy;
                    break;
                case 2:
                    x -= dx;
                    break;
                default:
                    y -= dy;
                    break;
            }
            return [x, y];
        };
    }

    // TODO reuse arrays?
    function zeroArray(n) {
        var a = [],
            i = -1;
        while (++i < n) a[i] = 0;
        return a;
    }

    var cloudRadians = Math.PI / 180,
        cw = 1 << 11 >> 5,
        ch = 1 << 11,
        canvas,
        ratio = 1;

    if (typeof document !== "undefined") {
        canvas = document.createElement("canvas");
        canvas.width = 1;
        canvas.height = 1;
        ratio = Math.sqrt(canvas.getContext("2d").getImageData(0, 0, 1, 1).data.length >> 2);
        canvas.width = (cw << 5) / ratio;
        canvas.height = ch / ratio;
    } else {
        // node-canvas support
        var Canvas = require("canvas");
        canvas = new Canvas(cw << 5, ch);
    }

    var c = canvas.getContext("2d"),
        spirals = {
            archimedean: archimedeanSpiral,
            rectangular: rectangularSpiral
        };
    c.fillStyle = c.strokeStyle = "red";
    c.textAlign = "center";

    exports.cloud = cloud;
})(typeof exports === "undefined" ? d3.layout || (d3.layout = {}) : exports);
