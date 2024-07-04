// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_db_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVerseDBModelCollection on Isar {
  IsarCollection<VerseDBModel> get verseDBModels => this.collection();
}

const VerseDBModelSchema = CollectionSchema(
  name: r'VerseDBModel',
  id: 1180768730614294227,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'realId': PropertySchema(
      id: 1,
      name: r'realId',
      type: IsarType.string,
    ),
    r'verse': PropertySchema(
      id: 2,
      name: r'verse',
      type: IsarType.string,
    )
  },
  estimateSize: _verseDBModelEstimateSize,
  serialize: _verseDBModelSerialize,
  deserialize: _verseDBModelDeserialize,
  deserializeProp: _verseDBModelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _verseDBModelGetId,
  getLinks: _verseDBModelGetLinks,
  attach: _verseDBModelAttach,
  version: '3.1.0+1',
);

int _verseDBModelEstimateSize(
  VerseDBModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.realId.length * 3;
  bytesCount += 3 + object.verse.length * 3;
  return bytesCount;
}

void _verseDBModelSerialize(
  VerseDBModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.realId);
  writer.writeString(offsets[2], object.verse);
}

VerseDBModel _verseDBModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = VerseDBModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.realId = reader.readString(offsets[1]);
  object.verse = reader.readString(offsets[2]);
  return object;
}

P _verseDBModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _verseDBModelGetId(VerseDBModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _verseDBModelGetLinks(VerseDBModel object) {
  return [];
}

void _verseDBModelAttach(
    IsarCollection<dynamic> col, Id id, VerseDBModel object) {}

extension VerseDBModelQueryWhereSort
    on QueryBuilder<VerseDBModel, VerseDBModel, QWhere> {
  QueryBuilder<VerseDBModel, VerseDBModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VerseDBModelQueryWhere
    on QueryBuilder<VerseDBModel, VerseDBModel, QWhereClause> {
  QueryBuilder<VerseDBModel, VerseDBModel, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension VerseDBModelQueryFilter
    on QueryBuilder<VerseDBModel, VerseDBModel, QFilterCondition> {
  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> realIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'realId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'realId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> realIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'realId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'realId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'realId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'realId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> realIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'realId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'realId',
        value: '',
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      realIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'realId',
        value: '',
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> verseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      verseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> verseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> verseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'verse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      verseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> verseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> verseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'verse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition> verseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'verse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      verseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'verse',
        value: '',
      ));
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterFilterCondition>
      verseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'verse',
        value: '',
      ));
    });
  }
}

extension VerseDBModelQueryObject
    on QueryBuilder<VerseDBModel, VerseDBModel, QFilterCondition> {}

extension VerseDBModelQueryLinks
    on QueryBuilder<VerseDBModel, VerseDBModel, QFilterCondition> {}

extension VerseDBModelQuerySortBy
    on QueryBuilder<VerseDBModel, VerseDBModel, QSortBy> {
  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> sortByRealId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realId', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> sortByRealIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realId', Sort.desc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> sortByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> sortByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }
}

extension VerseDBModelQuerySortThenBy
    on QueryBuilder<VerseDBModel, VerseDBModel, QSortThenBy> {
  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByRealId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realId', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByRealIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'realId', Sort.desc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByVerse() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.asc);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QAfterSortBy> thenByVerseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'verse', Sort.desc);
    });
  }
}

extension VerseDBModelQueryWhereDistinct
    on QueryBuilder<VerseDBModel, VerseDBModel, QDistinct> {
  QueryBuilder<VerseDBModel, VerseDBModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QDistinct> distinctByRealId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'realId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<VerseDBModel, VerseDBModel, QDistinct> distinctByVerse(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'verse', caseSensitive: caseSensitive);
    });
  }
}

extension VerseDBModelQueryProperty
    on QueryBuilder<VerseDBModel, VerseDBModel, QQueryProperty> {
  QueryBuilder<VerseDBModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<VerseDBModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<VerseDBModel, String, QQueryOperations> realIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'realId');
    });
  }

  QueryBuilder<VerseDBModel, String, QQueryOperations> verseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'verse');
    });
  }
}
