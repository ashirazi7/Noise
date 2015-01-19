within Modelica_Noise.Blocks.Statistics;
block ContinuousMean
  "Calculates the empirical expectation (mean) value of its input signal"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Modelica.SIunits.Time t_eps(min=0.0)=1e-7
    "Mean value calculation starts at startTime + t_eps"
    annotation(Dialog(group="Advanced"));

  Modelica.Blocks.Interfaces.RealInput u "Noisy input signal" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    "Expectation (mean) value of the input signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

protected
  Real mu_0 "Internal integrator variable";
  parameter Real t_0(fixed=false) "Start time";

initial equation
  t_0  = time;
  mu_0 = 0;
equation
  der(mu_0) = u;
  y = if time > t_0+t_eps then mu_0/(time-t_0) else u;

  annotation (Documentation(revisions=""), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Polygon(
          points={{94,0},{72,8},{72,-8},{94,0}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-86,0},{72,0}}, color={192,192,192}),
        Line(points={{-76,68},{-76,-80}}, color={192,192,192}),
        Polygon(
          points={{-76,90},{-84,68},{-68,68},{-76,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
           points={{-76,-31},{-62,-31},{-62,-15},{-54,-15},{-54,-63},{-46,-63},
              {-46,-41},{-38,-41},{-38,43},{-30,43},{-30,11},{-30,11},{-30,-49},
              {-20,-49},{-20,-31},{-10,-31},{-10,-59},{0,-59},{0,23},{6,23},{6,
              37},{12,37},{12,-19},{22,-19},{22,-7},{28,-7},{28,-37},{38,-37},
              {38,35},{48,35},{48,1},{56,1},{56,-65},{66,-65}},
            color={215,215,215}),
        Line(
          points={{-76,-24},{70,-24}},
          color={0,0,0},
          smooth=Smooth.None)}));
end ContinuousMean;
