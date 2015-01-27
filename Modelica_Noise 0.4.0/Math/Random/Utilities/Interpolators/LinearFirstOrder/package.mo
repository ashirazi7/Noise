within Modelica_Noise.Math.Random.Utilities.Interpolators;
package LinearFirstOrder "A linear first order filter (k / (Ts + 1))"
  extends Interfaces.PartialInterpolatorWithKernel(
                                                final continuous=true,
                                                final nFuture=0,
                                                nPast=5,
                                                varianceFactor = 0.900004539919624);

  constant Real k=1 "Gain";
  constant Modelica.SIunits.Period T=0.1 "Time Constant";


  redeclare function extends kernel
  "Kernel for first-order ideal low pass (k / (Ts + 1))"
protected
    Real a;
    Real b;
  algorithm

    // Transfer function:
    // G = k / (Ts + 1)
    //   = b / ( s + a) => b = k/T, a = 1/T
    b := k/T;
    a := 1/T;

    // Impulse response:
    // h =  b *   e^(-at)  for t >= 0
    //
    // Step response:
    // h = b/a*(1-e^(-at)) for t >= 0
    //
    // Step response after a zero-order hold:
    // h = b/a*(1-e^(-at))           for t >= 0 and t < 1
    //   = b/a*(1-e^(-a ))*(-a(t-1)) for t >= 1
    h := if t < 0 then 0 else
         if t < 1 then b/a * (1-exp(-a*t)) else
                       b/a * (1-exp(-a))   * exp(-a* (t-1.0));
    annotation(Inline=true);
  end kernel;


annotation (Icon(graphics={
                  Line(
      points={{-90,-48},{-22,-48},{-22,-48},{6,46},{88,46}},
      color={0,0,0},
      smooth=Smooth.Bezier)}));
end LinearFirstOrder;
