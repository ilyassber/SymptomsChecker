class DayStats {
  DayStats({
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
  });

  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final double casesPerOneMillion;
  final double deathsPerOneMillion;

  static DayStats fromMap(Map<String, dynamic> map) {
    return DayStats(
      cases: map['cases'],
      todayCases: map['todayCases'],
      deaths: map['deaths'],
      todayDeaths: map['todayDeaths'],
      recovered: map['recovered'],
      active: map['active'],
      critical: map['critical'],
      casesPerOneMillion: double.parse(map['casesPerOneMillion'].toString()),
      deathsPerOneMillion: double.parse(map['deathsPerOneMillion'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cases': cases,
      'todayCases': todayCases,
      'deaths': deaths,
      'todayDeaths': todayDeaths,
      'recovered': recovered,
      'active': active,
      'critical': critical,
      'casesPerOneMillion': casesPerOneMillion,
      'deathsPerOneMillion': deathsPerOneMillion,
    };
  }
}
