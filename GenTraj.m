function qc = GenTraj(qdi,qdf,t)
    tf=0.5;
    traj = @(t) 10*(t/tf).^3 - 15*(t/tf).^4 + 6*(t/tf).^5;
    qc = traj(t)*(qdf-qdi)+qdi;
end

