import numpy as np
import scipy


def F_1(t, mu, sigma):
    """CDF of the log normal distribution"""
    z = (np.log(t) - mu) / (sigma * np.sqrt(2))
    error_function = scipy.special.erf(z)
    return 0.5 * (1 + error_function)


def F_2(t, mu, sigma):
    """CDF of the normal distribution"""
    z = (t - mu) / (sigma * np.sqrt(2))
    error_function = scipy.special.erf(z)
    return 0.5 * (1 + error_function)


if __name__ == "__main__":
    MU_1 = 2.6543
    SIGMA_1 = 2.3610

    MU_2 = 36.5430
    SIGMA_2 = 4.4290

    F_1_t = F_1(35, 2.6543, 2.3610)
    F_2_t = F_2(35, 36.5430, 4.4290)

    P = (1 - F_1_t) * (1 - F_2_t)

    print(P)
