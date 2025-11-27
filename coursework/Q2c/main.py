import numpy as np


def weibull_reliability(t, beta, eta):
    """PDF for 2 parameter weibull distribution"""
    return np.exp(-((t / eta) ** beta))


def system_reliability(
    gyro_r,
    battery_r,
    computer_r,
    control_r,
    electrical_r,
    ttc_r,
    solar_r,
    thruster_r,
    print_reliabilities=False,
):
    """Returns the total system reliability based on the reliability of components"""
    # Subsystems
    gyro_subsystem = 1 - (1 - gyro_r) ** 3
    battery_subsystem = 1 - (1 - battery_r) ** 2
    solar_subsystem = 1 - (
        (1 - solar_r) ** 4 + 4 * solar_r * (1 - solar_r) ** 3 + 6 * solar_r**2 * (1 - solar_r) ** 2
    )

    # Print all reliabilities if flag is true
    if print_reliabilities:
        print(f"gyro reliability = {gyro_r}")
        print(f"gyro subsystem reliability = {gyro_subsystem}")
        print(f"battery reliability = {battery_r}")
        print(f"battery subsystem reliability = {battery_subsystem}")
        print(f"computer reliability = {computer_r}")
        print(f"control processor reliability = {control_r}")
        print(f"electrical distribution reliability = {electrical_r}")
        print(f"telemetry tracking & command reliability = {ttc_r}")
        print(f"solar array reliability = {solar_r}")
        print(f"solar subsystem reliability = {solar_subsystem}")
        print(f"thruster reliability = {thruster_r}")

    # Total system reliability is product of all systems
    return (
        gyro_subsystem
        * battery_subsystem
        * computer_r
        * control_r
        * electrical_r
        * ttc_r
        * solar_subsystem
        * thruster_r
    )


if __name__ == "__main__":
    t = 20  # time

    # Component reliabilities (neglecting active redundant and m-n as these are now in func)
    gyro_r = weibull_reliability(t, 0.7, 3800)
    battery_r = weibull_reliability(t, 0.7, 700)
    computer_r = weibull_reliability(t, 0.88, 900)
    control_r = weibull_reliability(t, 1.4, 400)
    electrical_r = weibull_reliability(t, 0.5, 1600)
    ttc_r = weibull_reliability(t, 0.39, 50000)
    solar_r = weibull_reliability(t, 0.4, 150000)
    thruster_r = weibull_reliability(t, 0.33, 6200)

    # Construct Dictionary of Components
    components = {
        "gyro": gyro_r,
        "battery": battery_r,
        "computer": computer_r,
        "control_processor": control_r,
        "electrical_distribution": electrical_r,
        "telemetry_tracking_command": ttc_r,
        "solar_array": solar_r,
        "thruster": thruster_r,
    }

    # Compute normal system reliability
    R_sys = system_reliability(
        gyro_r, battery_r, computer_r, control_r, electrical_r, ttc_r, solar_r, thruster_r, True
    )
    print("Normal System reliability:", R_sys)

    # Compute Birnbaum importance for each component
    birnbaum_importance = {}
    for name, r in components.items():
        # Component works
        comps_work = components.copy()
        comps_work[name] = 1.0
        R_work = system_reliability(
            comps_work["gyro"],
            comps_work["battery"],
            comps_work["computer"],
            comps_work["control_processor"],
            comps_work["electrical_distribution"],
            comps_work["telemetry_tracking_command"],
            comps_work["solar_array"],
            comps_work["thruster"],
        )

        # Component fails
        comps_fail = components.copy()
        comps_fail[name] = 0.0
        R_fail = system_reliability(
            comps_fail["gyro"],
            comps_fail["battery"],
            comps_fail["computer"],
            comps_fail["control_processor"],
            comps_fail["electrical_distribution"],
            comps_fail["telemetry_tracking_command"],
            comps_fail["solar_array"],
            comps_fail["thruster"],
        )

        birnbaum_importance[name] = R_work - R_fail

    print("\nBirnbaum Importance Measures:")
    for name, importance in birnbaum_importance.items():
        print(f"{name}: {importance:.6f}")
