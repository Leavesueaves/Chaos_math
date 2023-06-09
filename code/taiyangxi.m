%initializing variables
G = 6.67408e-11; %gravitational constant 
sun_mass = 1.989e30; %mass of the sun in kg
earth_distance = 149.6e9; %distance of earth from sun in meters
earth_mass = 5.972e24; %mass of earth in kg
moon_distance = 384400000; %distance of moon from earth in meters
moon_mass = 7.342e22; %mass of moon in kg
dt = 86400; %time step of 1 day in seconds

%initial positions and velocities
sun_pos = [0,0,0];
sun_vel = [0,0,0];
earth_pos = [earth_distance,0,0];
earth_vel = [0,sqrt(G*sun_mass/earth_distance),0];
moon_pos = [earth_pos(1)+moon_distance,0,0];
moon_vel = [0,earth_vel(2)+sqrt(G*earth_mass/moon_distance),0];

%creating arrays to store positions and velocities
sun_pos_array = zeros(365,3);
sun_vel_array = zeros(365,3);
earth_pos_array = zeros(365,3);
earth_vel_array = zeros(365,3);
moon_pos_array = zeros(365,3);
moon_vel_array = zeros(365,3);

for i = 1:365
    %updating positions using velocities and time step
    sun_pos = sun_pos + sun_vel*dt;
    earth_pos = earth_pos + earth_vel*dt;
    moon_pos = moon_pos + moon_vel*dt;
    
    %calculating accelerations due to gravity
    earth_acc = G*sun_mass/norm(sun_pos-earth_pos)^2*(sun_pos-earth_pos)/earth_mass;
    moon_acc = G*earth_mass/norm(earth_pos-moon_pos)^2*(earth_pos-moon_pos)/moon_mass;
    
    %updating velocities using accelerations and time step
    sun_vel = sun_vel + (1/sun_mass)*(earth_acc*earth_mass+moon_acc*moon_mass)*dt;
    earth_vel = earth_vel + earth_acc*dt;
    moon_vel = moon_vel + moon_acc*dt;
    
    %storing positions and velocities in arrays
    sun_pos_array(i,:) = sun_pos;
    sun_vel_array(i,:) = sun_vel;
    earth_pos_array(i,:) = earth_pos;
    earth_vel_array(i,:) = earth_vel;
    moon_pos_array(i,:) = moon_pos;
    moon_vel_array(i,:) = moon_vel;
end

%plotting the trajectories of the sun, earth, and moon
plot3(sun_pos_array(:,1),sun_pos_array(:,2),sun_pos_array(:,3),'r');
hold on
plot3(earth_pos_array(:,1),earth_pos_array(:,2),earth_pos_array(:,3),'b');
plot3(moon_pos_array(:,1),moon_pos_array(:,2),moon_pos_array(:,3),'g');
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
title('Trajectories of Sun, Earth, and Moon');
legend('Sun','Earth','Moon');
grid on