import numpy as np
import random


def weibull_reliability(t, beta, eta):
    return np.exp(-((t / eta) ** beta))


if __name__ == "__main__":
    t = 20  # Assuming that everything is in years

    gyro_beta = 0.7
    gyro_eta = 3800
    gyro_reliability = weibull_reliability(t, gyro_beta, gyro_eta)
    gyro_subsystem_reliability = 1 - (1 - gyro_reliability) ** 3

    battery_beta = 0.7
    battery_eta = 700
    battery_reliability = weibull_reliability(t, battery_beta, battery_eta)
    battery_subsystem_reliability = 1 - (1 - battery_reliability) ** 2

    computer_beta = 0.88
    computer_eta = 900
    computer_reliability = weibull_reliability(t, computer_beta, computer_eta)

    control_processor_beta = 1.4
    control_processor_eta = 400
    control_processor_reliability = weibull_reliability(
        t, control_processor_beta, control_processor_eta
    )

    electrical_distribution_beta = 0.5
    electrical_distribution_eta = 1600
    electrical_distribution_reliability = weibull_reliability(
        t, electrical_distribution_beta, electrical_distribution_eta
    )

    telemetry_tracking_command_beta = 0.39
    telemetry_tracking_command_eta = 50000
    telemetry_tracking_command_reliability = weibull_reliability(
        t, telemetry_tracking_command_beta, telemetry_tracking_command_eta
    )

    solar_array_beta = 0.4
    solar_array_eta = 150000
    solar_array_reliability = weibull_reliability(t, solar_array_beta, solar_array_eta)
    solar_array_subsystem_reliability = 1 - (
        (1 - solar_array_reliability) ** 4
        + 4 * solar_array_reliability * (1 - solar_array_reliability) ** 3
        + 6 * solar_array_reliability**2 * (1 - solar_array_reliability) ** 2
    )

    thruster_beta = 0.33
    thruster_eta = 6200
    thruster_reliability = weibull_reliability(t, thruster_beta, thruster_eta)

    single_satellite_reliability = (
        gyro_subsystem_reliability
        * battery_subsystem_reliability
        * computer_reliability
        * control_processor_reliability
        * electrical_distribution_reliability
        * telemetry_tracking_command_reliability
        * solar_array_subsystem_reliability
        * thruster_reliability
    )

    # Define possible signal paths
    paths = [
        ["S3", "S6"],
        ["S3", "S5"],
        ["S2", "S5"],
        ["S2", "S6"],
        ["S2", "S4"],
        ["S1", "S5"],
        ["S1", "S4"],
    ]

    #  Define number of trails
    N = 500
    success = 0

    for _ in range(N):
        # Cycle through each satellite, defining if it is active or has failed
        state = {}
        for i in range(1, 7):
            sat_name = f"S{i}"
            alive = random.random() < single_satellite_reliability
            state[sat_name] = alive

        # Check if any path is viable
        path_ok = False
        for path in paths:
            if all(state[sat] for sat in path):
                path_ok = True
                break

        # If there was at least one viable path, then increment the number of successes
        if path_ok:
            success = success + 1

    probability = success / N
    print(probability)
