function RR_Animation(t,y,refFun,l1,l2,file_name,export_video)
    %% Animation use
    % plotting the robot in wrokspace!
    % === require data ===
    %   y (th1, th2)
    %   l1, l2
    %   refFun
    %   t

    frame_rate = 30;

    %% Interpolation for linear time
    tspan = t(end) - t(1);
    t_lin = linspace(t(1), t(end), tspan*frame_rate);


    %% position of end-effector
    % q1 = [x1,y1,z1,1]
    q1_lin = interp1(t,y(:,1),t_lin,'spline')';
    q2_lin = interp1(t,y(:,3),t_lin,'spline')';
    [p1,p2] = RR_EndEffector(l1,l2,q1_lin,q2_lin);

    % reference
    [q_ref,v_ref,a_ref] = refFun(t);
    q_ref = interp1(t,q_ref,t_lin,'spline')';

    [p1_ref, p2_ref] = RR_EndEffector(l1,l2,q_ref,q_ref);


    fig = figure;

    
    if export_video
        movieVector(length(t_lin)) = getframe;
    end
    
    for i = 1:length(t_lin)
        % clear the figure
        clf;

        ti = i;

        % plot the links
        plot([0 p1(ti,1)], [0 p1(ti,2)], 'b','LineWidth',2); 
        hold on;
        plot([p1(ti,1),p2(ti,1)], [p1(ti,2),p2(ti,2)], 'r','LineWidth',2);

        % plot the reference
        plot([0 p1_ref(ti,1)], [0 p1_ref(ti,2)], 'b--','LineWidth',2);
        plot([p1_ref(ti,1),p2_ref(ti,1)], [p1_ref(ti,2),p2_ref(ti,2)], 'r--','LineWidth',2);


        title(['RR with controller PD and ref Step. t=',num2str(t_lin(i))]);
        xlim([-0.5,0.5]);
        ylim([-0.5,0.5]);

    %     pause(1.0/frame_rate*2)
        if export_video
            movieVector(i) = getframe(fig);
        end
    end

    if export_video
%         myVW = VideoWriter('animation\RR_PDcontrol','MPEG-4');
        myVW = VideoWriter(['animation\',file_name],'MPEG-4');
        myVW.FrameRate = frame_rate/2;

        open(myVW);
        writeVideo(myVW,movieVector);
        close(myVW);

        disp(['Video export at ', file_name,' Done!!']);
    end
end