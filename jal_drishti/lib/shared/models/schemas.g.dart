// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMapNodeCollection on Isar {
  IsarCollection<MapNode> get mapNodes => this.collection();
}

const MapNodeSchema = CollectionSchema(
  name: r'MapNode',
  id: -8160305010458711260,
  properties: {
    r'downvotes': PropertySchema(
      id: 0,
      name: r'downvotes',
      type: IsarType.long,
    ),
    r'isVerified': PropertySchema(
      id: 1,
      name: r'isVerified',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 2,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 3,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'nodeId': PropertySchema(
      id: 4,
      name: r'nodeId',
      type: IsarType.string,
    ),
    r'nodeType': PropertySchema(
      id: 5,
      name: r'nodeType',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 6,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'upvotes': PropertySchema(
      id: 7,
      name: r'upvotes',
      type: IsarType.long,
    )
  },
  estimateSize: _mapNodeEstimateSize,
  serialize: _mapNodeSerialize,
  deserialize: _mapNodeDeserialize,
  deserializeProp: _mapNodeDeserializeProp,
  idName: r'id',
  indexes: {
    r'nodeId': IndexSchema(
      id: -6491850230428693976,
      name: r'nodeId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'nodeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _mapNodeGetId,
  getLinks: _mapNodeGetLinks,
  attach: _mapNodeAttach,
  version: '3.1.0+1',
);

int _mapNodeEstimateSize(
  MapNode object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nodeId.length * 3;
  bytesCount += 3 + object.nodeType.length * 3;
  return bytesCount;
}

void _mapNodeSerialize(
  MapNode object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.downvotes);
  writer.writeBool(offsets[1], object.isVerified);
  writer.writeDouble(offsets[2], object.latitude);
  writer.writeDouble(offsets[3], object.longitude);
  writer.writeString(offsets[4], object.nodeId);
  writer.writeString(offsets[5], object.nodeType);
  writer.writeDateTime(offsets[6], object.timestamp);
  writer.writeLong(offsets[7], object.upvotes);
}

MapNode _mapNodeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MapNode();
  object.downvotes = reader.readLong(offsets[0]);
  object.id = id;
  object.isVerified = reader.readBool(offsets[1]);
  object.latitude = reader.readDouble(offsets[2]);
  object.longitude = reader.readDouble(offsets[3]);
  object.nodeId = reader.readString(offsets[4]);
  object.nodeType = reader.readString(offsets[5]);
  object.timestamp = reader.readDateTime(offsets[6]);
  object.upvotes = reader.readLong(offsets[7]);
  return object;
}

P _mapNodeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _mapNodeGetId(MapNode object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _mapNodeGetLinks(MapNode object) {
  return [];
}

void _mapNodeAttach(IsarCollection<dynamic> col, Id id, MapNode object) {
  object.id = id;
}

extension MapNodeByIndex on IsarCollection<MapNode> {
  Future<MapNode?> getByNodeId(String nodeId) {
    return getByIndex(r'nodeId', [nodeId]);
  }

  MapNode? getByNodeIdSync(String nodeId) {
    return getByIndexSync(r'nodeId', [nodeId]);
  }

  Future<bool> deleteByNodeId(String nodeId) {
    return deleteByIndex(r'nodeId', [nodeId]);
  }

  bool deleteByNodeIdSync(String nodeId) {
    return deleteByIndexSync(r'nodeId', [nodeId]);
  }

  Future<List<MapNode?>> getAllByNodeId(List<String> nodeIdValues) {
    final values = nodeIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'nodeId', values);
  }

  List<MapNode?> getAllByNodeIdSync(List<String> nodeIdValues) {
    final values = nodeIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'nodeId', values);
  }

  Future<int> deleteAllByNodeId(List<String> nodeIdValues) {
    final values = nodeIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'nodeId', values);
  }

  int deleteAllByNodeIdSync(List<String> nodeIdValues) {
    final values = nodeIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'nodeId', values);
  }

  Future<Id> putByNodeId(MapNode object) {
    return putByIndex(r'nodeId', object);
  }

  Id putByNodeIdSync(MapNode object, {bool saveLinks = true}) {
    return putByIndexSync(r'nodeId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNodeId(List<MapNode> objects) {
    return putAllByIndex(r'nodeId', objects);
  }

  List<Id> putAllByNodeIdSync(List<MapNode> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'nodeId', objects, saveLinks: saveLinks);
  }
}

extension MapNodeQueryWhereSort on QueryBuilder<MapNode, MapNode, QWhere> {
  QueryBuilder<MapNode, MapNode, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MapNodeQueryWhere on QueryBuilder<MapNode, MapNode, QWhereClause> {
  QueryBuilder<MapNode, MapNode, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterWhereClause> nodeIdEqualTo(
      String nodeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nodeId',
        value: [nodeId],
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterWhereClause> nodeIdNotEqualTo(
      String nodeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nodeId',
              lower: [],
              upper: [nodeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nodeId',
              lower: [nodeId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nodeId',
              lower: [nodeId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nodeId',
              lower: [],
              upper: [nodeId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MapNodeQueryFilter
    on QueryBuilder<MapNode, MapNode, QFilterCondition> {
  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> downvotesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'downvotes',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> downvotesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'downvotes',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> downvotesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'downvotes',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> downvotesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'downvotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> isVerifiedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nodeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nodeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeId',
        value: '',
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nodeId',
        value: '',
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nodeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nodeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nodeType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nodeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nodeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nodeType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nodeType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeType',
        value: '',
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> nodeTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nodeType',
        value: '',
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> upvotesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'upvotes',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> upvotesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'upvotes',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> upvotesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'upvotes',
        value: value,
      ));
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterFilterCondition> upvotesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'upvotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MapNodeQueryObject
    on QueryBuilder<MapNode, MapNode, QFilterCondition> {}

extension MapNodeQueryLinks
    on QueryBuilder<MapNode, MapNode, QFilterCondition> {}

extension MapNodeQuerySortBy on QueryBuilder<MapNode, MapNode, QSortBy> {
  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByDownvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByDownvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByIsVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByNodeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByNodeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByNodeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeType', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByNodeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeType', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByUpvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> sortByUpvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.desc);
    });
  }
}

extension MapNodeQuerySortThenBy
    on QueryBuilder<MapNode, MapNode, QSortThenBy> {
  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByDownvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByDownvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'downvotes', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByIsVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByNodeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByNodeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByNodeType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeType', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByNodeTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeType', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByUpvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.asc);
    });
  }

  QueryBuilder<MapNode, MapNode, QAfterSortBy> thenByUpvotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'upvotes', Sort.desc);
    });
  }
}

extension MapNodeQueryWhereDistinct
    on QueryBuilder<MapNode, MapNode, QDistinct> {
  QueryBuilder<MapNode, MapNode, QDistinct> distinctByDownvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'downvotes');
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVerified');
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByNodeId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByNodeType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<MapNode, MapNode, QDistinct> distinctByUpvotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'upvotes');
    });
  }
}

extension MapNodeQueryProperty
    on QueryBuilder<MapNode, MapNode, QQueryProperty> {
  QueryBuilder<MapNode, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MapNode, int, QQueryOperations> downvotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'downvotes');
    });
  }

  QueryBuilder<MapNode, bool, QQueryOperations> isVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVerified');
    });
  }

  QueryBuilder<MapNode, double, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<MapNode, double, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<MapNode, String, QQueryOperations> nodeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeId');
    });
  }

  QueryBuilder<MapNode, String, QQueryOperations> nodeTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeType');
    });
  }

  QueryBuilder<MapNode, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<MapNode, int, QQueryOperations> upvotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'upvotes');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatMessageCollection on Isar {
  IsarCollection<ChatMessage> get chatMessages => this.collection();
}

const ChatMessageSchema = CollectionSchema(
  name: r'ChatMessage',
  id: 35366979330584919,
  properties: {
    r'hopCount': PropertySchema(
      id: 0,
      name: r'hopCount',
      type: IsarType.long,
    ),
    r'messageId': PropertySchema(
      id: 1,
      name: r'messageId',
      type: IsarType.string,
    ),
    r'senderId': PropertySchema(
      id: 2,
      name: r'senderId',
      type: IsarType.string,
    ),
    r'textPayload': PropertySchema(
      id: 3,
      name: r'textPayload',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 4,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _chatMessageEstimateSize,
  serialize: _chatMessageSerialize,
  deserialize: _chatMessageDeserialize,
  deserializeProp: _chatMessageDeserializeProp,
  idName: r'id',
  indexes: {
    r'messageId': IndexSchema(
      id: -635287409172016016,
      name: r'messageId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'messageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _chatMessageGetId,
  getLinks: _chatMessageGetLinks,
  attach: _chatMessageAttach,
  version: '3.1.0+1',
);

int _chatMessageEstimateSize(
  ChatMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.messageId.length * 3;
  bytesCount += 3 + object.senderId.length * 3;
  bytesCount += 3 + object.textPayload.length * 3;
  return bytesCount;
}

void _chatMessageSerialize(
  ChatMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hopCount);
  writer.writeString(offsets[1], object.messageId);
  writer.writeString(offsets[2], object.senderId);
  writer.writeString(offsets[3], object.textPayload);
  writer.writeDateTime(offsets[4], object.timestamp);
}

ChatMessage _chatMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatMessage();
  object.hopCount = reader.readLong(offsets[0]);
  object.id = id;
  object.messageId = reader.readString(offsets[1]);
  object.senderId = reader.readString(offsets[2]);
  object.textPayload = reader.readString(offsets[3]);
  object.timestamp = reader.readDateTime(offsets[4]);
  return object;
}

P _chatMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _chatMessageGetId(ChatMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chatMessageGetLinks(ChatMessage object) {
  return [];
}

void _chatMessageAttach(
    IsarCollection<dynamic> col, Id id, ChatMessage object) {
  object.id = id;
}

extension ChatMessageQueryWhereSort
    on QueryBuilder<ChatMessage, ChatMessage, QWhere> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChatMessageQueryWhere
    on QueryBuilder<ChatMessage, ChatMessage, QWhereClause> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> messageIdEqualTo(
      String messageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'messageId',
        value: [messageId],
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterWhereClause> messageIdNotEqualTo(
      String messageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [messageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'messageId',
              lower: [],
              upper: [messageId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ChatMessageQueryFilter
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> hopCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hopCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      hopCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hopCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      hopCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hopCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> hopCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hopCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      messageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> senderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> senderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition> senderIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      senderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textPayload',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textPayload',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textPayload',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textPayload',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      textPayloadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textPayload',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ChatMessageQueryObject
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {}

extension ChatMessageQueryLinks
    on QueryBuilder<ChatMessage, ChatMessage, QFilterCondition> {}

extension ChatMessageQuerySortBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByHopCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hopCount', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByHopCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hopCount', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTextPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textPayload', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTextPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textPayload', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension ChatMessageQuerySortThenBy
    on QueryBuilder<ChatMessage, ChatMessage, QSortThenBy> {
  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByHopCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hopCount', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByHopCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hopCount', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTextPayload() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textPayload', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTextPayloadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textPayload', Sort.desc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension ChatMessageQueryWhereDistinct
    on QueryBuilder<ChatMessage, ChatMessage, QDistinct> {
  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByHopCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hopCount');
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctBySenderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByTextPayload(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textPayload', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatMessage, ChatMessage, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension ChatMessageQueryProperty
    on QueryBuilder<ChatMessage, ChatMessage, QQueryProperty> {
  QueryBuilder<ChatMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatMessage, int, QQueryOperations> hopCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hopCount');
    });
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<ChatMessage, String, QQueryOperations> textPayloadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textPayload');
    });
  }

  QueryBuilder<ChatMessage, DateTime, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeatherForecastCollection on Isar {
  IsarCollection<WeatherForecast> get weatherForecasts => this.collection();
}

const WeatherForecastSchema = CollectionSchema(
  name: r'WeatherForecast',
  id: 5978684880315636015,
  properties: {
    r'forecastJson': PropertySchema(
      id: 0,
      name: r'forecastJson',
      type: IsarType.string,
    ),
    r'lastUpdated': PropertySchema(
      id: 1,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'locationKey': PropertySchema(
      id: 2,
      name: r'locationKey',
      type: IsarType.string,
    )
  },
  estimateSize: _weatherForecastEstimateSize,
  serialize: _weatherForecastSerialize,
  deserialize: _weatherForecastDeserialize,
  deserializeProp: _weatherForecastDeserializeProp,
  idName: r'id',
  indexes: {
    r'locationKey': IndexSchema(
      id: 1950685211417560871,
      name: r'locationKey',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'locationKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _weatherForecastGetId,
  getLinks: _weatherForecastGetLinks,
  attach: _weatherForecastAttach,
  version: '3.1.0+1',
);

int _weatherForecastEstimateSize(
  WeatherForecast object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.forecastJson.length * 3;
  bytesCount += 3 + object.locationKey.length * 3;
  return bytesCount;
}

void _weatherForecastSerialize(
  WeatherForecast object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.forecastJson);
  writer.writeDateTime(offsets[1], object.lastUpdated);
  writer.writeString(offsets[2], object.locationKey);
}

WeatherForecast _weatherForecastDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WeatherForecast();
  object.forecastJson = reader.readString(offsets[0]);
  object.id = id;
  object.lastUpdated = reader.readDateTime(offsets[1]);
  object.locationKey = reader.readString(offsets[2]);
  return object;
}

P _weatherForecastDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weatherForecastGetId(WeatherForecast object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weatherForecastGetLinks(WeatherForecast object) {
  return [];
}

void _weatherForecastAttach(
    IsarCollection<dynamic> col, Id id, WeatherForecast object) {
  object.id = id;
}

extension WeatherForecastByIndex on IsarCollection<WeatherForecast> {
  Future<WeatherForecast?> getByLocationKey(String locationKey) {
    return getByIndex(r'locationKey', [locationKey]);
  }

  WeatherForecast? getByLocationKeySync(String locationKey) {
    return getByIndexSync(r'locationKey', [locationKey]);
  }

  Future<bool> deleteByLocationKey(String locationKey) {
    return deleteByIndex(r'locationKey', [locationKey]);
  }

  bool deleteByLocationKeySync(String locationKey) {
    return deleteByIndexSync(r'locationKey', [locationKey]);
  }

  Future<List<WeatherForecast?>> getAllByLocationKey(
      List<String> locationKeyValues) {
    final values = locationKeyValues.map((e) => [e]).toList();
    return getAllByIndex(r'locationKey', values);
  }

  List<WeatherForecast?> getAllByLocationKeySync(
      List<String> locationKeyValues) {
    final values = locationKeyValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'locationKey', values);
  }

  Future<int> deleteAllByLocationKey(List<String> locationKeyValues) {
    final values = locationKeyValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'locationKey', values);
  }

  int deleteAllByLocationKeySync(List<String> locationKeyValues) {
    final values = locationKeyValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'locationKey', values);
  }

  Future<Id> putByLocationKey(WeatherForecast object) {
    return putByIndex(r'locationKey', object);
  }

  Id putByLocationKeySync(WeatherForecast object, {bool saveLinks = true}) {
    return putByIndexSync(r'locationKey', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocationKey(List<WeatherForecast> objects) {
    return putAllByIndex(r'locationKey', objects);
  }

  List<Id> putAllByLocationKeySync(List<WeatherForecast> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'locationKey', objects, saveLinks: saveLinks);
  }
}

extension WeatherForecastQueryWhereSort
    on QueryBuilder<WeatherForecast, WeatherForecast, QWhere> {
  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WeatherForecastQueryWhere
    on QueryBuilder<WeatherForecast, WeatherForecast, QWhereClause> {
  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause>
      locationKeyEqualTo(String locationKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'locationKey',
        value: [locationKey],
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterWhereClause>
      locationKeyNotEqualTo(String locationKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationKey',
              lower: [],
              upper: [locationKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationKey',
              lower: [locationKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationKey',
              lower: [locationKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'locationKey',
              lower: [],
              upper: [locationKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension WeatherForecastQueryFilter
    on QueryBuilder<WeatherForecast, WeatherForecast, QFilterCondition> {
  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'forecastJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'forecastJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'forecastJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'forecastJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'forecastJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'forecastJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'forecastJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'forecastJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'forecastJson',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      forecastJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'forecastJson',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      lastUpdatedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      lastUpdatedLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      lastUpdatedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locationKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locationKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locationKey',
        value: '',
      ));
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterFilterCondition>
      locationKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locationKey',
        value: '',
      ));
    });
  }
}

extension WeatherForecastQueryObject
    on QueryBuilder<WeatherForecast, WeatherForecast, QFilterCondition> {}

extension WeatherForecastQueryLinks
    on QueryBuilder<WeatherForecast, WeatherForecast, QFilterCondition> {}

extension WeatherForecastQuerySortBy
    on QueryBuilder<WeatherForecast, WeatherForecast, QSortBy> {
  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      sortByForecastJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'forecastJson', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      sortByForecastJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'forecastJson', Sort.desc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      sortByLocationKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationKey', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      sortByLocationKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationKey', Sort.desc);
    });
  }
}

extension WeatherForecastQuerySortThenBy
    on QueryBuilder<WeatherForecast, WeatherForecast, QSortThenBy> {
  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      thenByForecastJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'forecastJson', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      thenByForecastJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'forecastJson', Sort.desc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      thenByLocationKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationKey', Sort.asc);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QAfterSortBy>
      thenByLocationKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locationKey', Sort.desc);
    });
  }
}

extension WeatherForecastQueryWhereDistinct
    on QueryBuilder<WeatherForecast, WeatherForecast, QDistinct> {
  QueryBuilder<WeatherForecast, WeatherForecast, QDistinct>
      distinctByForecastJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'forecastJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QDistinct>
      distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<WeatherForecast, WeatherForecast, QDistinct>
      distinctByLocationKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locationKey', caseSensitive: caseSensitive);
    });
  }
}

extension WeatherForecastQueryProperty
    on QueryBuilder<WeatherForecast, WeatherForecast, QQueryProperty> {
  QueryBuilder<WeatherForecast, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WeatherForecast, String, QQueryOperations>
      forecastJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'forecastJson');
    });
  }

  QueryBuilder<WeatherForecast, DateTime, QQueryOperations>
      lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<WeatherForecast, String, QQueryOperations>
      locationKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locationKey');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHydrometObservationCollection on Isar {
  IsarCollection<HydrometObservation> get hydrometObservations =>
      this.collection();
}

const HydrometObservationSchema = CollectionSchema(
  name: r'HydrometObservation',
  id: 1831592145795472833,
  properties: {
    r'freshnessStatus': PropertySchema(
      id: 0,
      name: r'freshnessStatus',
      type: IsarType.string,
    ),
    r'latitude': PropertySchema(
      id: 1,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 2,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'observedAt': PropertySchema(
      id: 3,
      name: r'observedAt',
      type: IsarType.dateTime,
    ),
    r'qualityStatus': PropertySchema(
      id: 4,
      name: r'qualityStatus',
      type: IsarType.string,
    ),
    r'rainfallMm': PropertySchema(
      id: 5,
      name: r'rainfallMm',
      type: IsarType.double,
    ),
    r'receivedAt': PropertySchema(
      id: 6,
      name: r'receivedAt',
      type: IsarType.dateTime,
    ),
    r'soilMoistureVolumetric': PropertySchema(
      id: 7,
      name: r'soilMoistureVolumetric',
      type: IsarType.double,
    ),
    r'source': PropertySchema(
      id: 8,
      name: r'source',
      type: IsarType.string,
    )
  },
  estimateSize: _hydrometObservationEstimateSize,
  serialize: _hydrometObservationSerialize,
  deserialize: _hydrometObservationDeserialize,
  deserializeProp: _hydrometObservationDeserializeProp,
  idName: r'id',
  indexes: {
    r'observedAt': IndexSchema(
      id: -7669707338121951927,
      name: r'observedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'observedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _hydrometObservationGetId,
  getLinks: _hydrometObservationGetLinks,
  attach: _hydrometObservationAttach,
  version: '3.1.0+1',
);

int _hydrometObservationEstimateSize(
  HydrometObservation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.freshnessStatus.length * 3;
  bytesCount += 3 + object.qualityStatus.length * 3;
  bytesCount += 3 + object.source.length * 3;
  return bytesCount;
}

void _hydrometObservationSerialize(
  HydrometObservation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.freshnessStatus);
  writer.writeDouble(offsets[1], object.latitude);
  writer.writeDouble(offsets[2], object.longitude);
  writer.writeDateTime(offsets[3], object.observedAt);
  writer.writeString(offsets[4], object.qualityStatus);
  writer.writeDouble(offsets[5], object.rainfallMm);
  writer.writeDateTime(offsets[6], object.receivedAt);
  writer.writeDouble(offsets[7], object.soilMoistureVolumetric);
  writer.writeString(offsets[8], object.source);
}

HydrometObservation _hydrometObservationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HydrometObservation();
  object.freshnessStatus = reader.readString(offsets[0]);
  object.id = id;
  object.latitude = reader.readDouble(offsets[1]);
  object.longitude = reader.readDouble(offsets[2]);
  object.observedAt = reader.readDateTime(offsets[3]);
  object.qualityStatus = reader.readString(offsets[4]);
  object.rainfallMm = reader.readDoubleOrNull(offsets[5]);
  object.receivedAt = reader.readDateTime(offsets[6]);
  object.soilMoistureVolumetric = reader.readDoubleOrNull(offsets[7]);
  object.source = reader.readString(offsets[8]);
  return object;
}

P _hydrometObservationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hydrometObservationGetId(HydrometObservation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hydrometObservationGetLinks(
    HydrometObservation object) {
  return [];
}

void _hydrometObservationAttach(
    IsarCollection<dynamic> col, Id id, HydrometObservation object) {
  object.id = id;
}

extension HydrometObservationQueryWhereSort
    on QueryBuilder<HydrometObservation, HydrometObservation, QWhere> {
  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhere>
      anyObservedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'observedAt'),
      );
    });
  }
}

extension HydrometObservationQueryWhere
    on QueryBuilder<HydrometObservation, HydrometObservation, QWhereClause> {
  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      observedAtEqualTo(DateTime observedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'observedAt',
        value: [observedAt],
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      observedAtNotEqualTo(DateTime observedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'observedAt',
              lower: [],
              upper: [observedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'observedAt',
              lower: [observedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'observedAt',
              lower: [observedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'observedAt',
              lower: [],
              upper: [observedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      observedAtGreaterThan(
    DateTime observedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'observedAt',
        lower: [observedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      observedAtLessThan(
    DateTime observedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'observedAt',
        lower: [],
        upper: [observedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterWhereClause>
      observedAtBetween(
    DateTime lowerObservedAt,
    DateTime upperObservedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'observedAt',
        lower: [lowerObservedAt],
        includeLower: includeLower,
        upper: [upperObservedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HydrometObservationQueryFilter on QueryBuilder<HydrometObservation,
    HydrometObservation, QFilterCondition> {
  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'freshnessStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'freshnessStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'freshnessStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'freshnessStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'freshnessStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'freshnessStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'freshnessStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'freshnessStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'freshnessStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      freshnessStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'freshnessStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      observedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'observedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      observedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'observedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      observedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'observedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      observedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'observedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'qualityStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'qualityStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'qualityStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'qualityStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'qualityStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'qualityStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'qualityStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'qualityStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      qualityStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'qualityStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      rainfallMmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rainfallMm',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      rainfallMmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rainfallMm',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      rainfallMmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rainfallMm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      rainfallMmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rainfallMm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      rainfallMmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rainfallMm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      rainfallMmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rainfallMm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      receivedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      receivedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      receivedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receivedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      receivedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receivedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      soilMoistureVolumetricIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'soilMoistureVolumetric',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      soilMoistureVolumetricIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'soilMoistureVolumetric',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      soilMoistureVolumetricEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilMoistureVolumetric',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      soilMoistureVolumetricGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilMoistureVolumetric',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      soilMoistureVolumetricLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilMoistureVolumetric',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      soilMoistureVolumetricBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilMoistureVolumetric',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }
}

extension HydrometObservationQueryObject on QueryBuilder<HydrometObservation,
    HydrometObservation, QFilterCondition> {}

extension HydrometObservationQueryLinks on QueryBuilder<HydrometObservation,
    HydrometObservation, QFilterCondition> {}

extension HydrometObservationQuerySortBy
    on QueryBuilder<HydrometObservation, HydrometObservation, QSortBy> {
  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByFreshnessStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'freshnessStatus', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByFreshnessStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'freshnessStatus', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByObservedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observedAt', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByObservedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observedAt', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByQualityStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityStatus', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByQualityStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityStatus', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByRainfallMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallMm', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByRainfallMmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallMm', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortByReceivedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortBySoilMoistureVolumetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureVolumetric', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortBySoilMoistureVolumetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureVolumetric', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension HydrometObservationQuerySortThenBy
    on QueryBuilder<HydrometObservation, HydrometObservation, QSortThenBy> {
  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByFreshnessStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'freshnessStatus', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByFreshnessStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'freshnessStatus', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByObservedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observedAt', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByObservedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observedAt', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByQualityStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityStatus', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByQualityStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'qualityStatus', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByRainfallMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallMm', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByRainfallMmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallMm', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenByReceivedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedAt', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenBySoilMoistureVolumetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureVolumetric', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenBySoilMoistureVolumetricDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureVolumetric', Sort.desc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }
}

extension HydrometObservationQueryWhereDistinct
    on QueryBuilder<HydrometObservation, HydrometObservation, QDistinct> {
  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByFreshnessStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'freshnessStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByObservedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observedAt');
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByQualityStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'qualityStatus',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByRainfallMm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rainfallMm');
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctByReceivedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receivedAt');
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctBySoilMoistureVolumetric() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilMoistureVolumetric');
    });
  }

  QueryBuilder<HydrometObservation, HydrometObservation, QDistinct>
      distinctBySource({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }
}

extension HydrometObservationQueryProperty
    on QueryBuilder<HydrometObservation, HydrometObservation, QQueryProperty> {
  QueryBuilder<HydrometObservation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HydrometObservation, String, QQueryOperations>
      freshnessStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'freshnessStatus');
    });
  }

  QueryBuilder<HydrometObservation, double, QQueryOperations>
      latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<HydrometObservation, double, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<HydrometObservation, DateTime, QQueryOperations>
      observedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observedAt');
    });
  }

  QueryBuilder<HydrometObservation, String, QQueryOperations>
      qualityStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'qualityStatus');
    });
  }

  QueryBuilder<HydrometObservation, double?, QQueryOperations>
      rainfallMmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rainfallMm');
    });
  }

  QueryBuilder<HydrometObservation, DateTime, QQueryOperations>
      receivedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedAt');
    });
  }

  QueryBuilder<HydrometObservation, double?, QQueryOperations>
      soilMoistureVolumetricProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilMoistureVolumetric');
    });
  }

  QueryBuilder<HydrometObservation, String, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAnomalyResultCollection on Isar {
  IsarCollection<AnomalyResult> get anomalyResults => this.collection();
}

const AnomalyResultSchema = CollectionSchema(
  name: r'AnomalyResult',
  id: 2308430605132259197,
  properties: {
    r'evaluatedAt': PropertySchema(
      id: 0,
      name: r'evaluatedAt',
      type: IsarType.dateTime,
    ),
    r'methodology': PropertySchema(
      id: 1,
      name: r'methodology',
      type: IsarType.string,
    ),
    r'rainfallValue': PropertySchema(
      id: 2,
      name: r'rainfallValue',
      type: IsarType.double,
    ),
    r'rainfallZScore': PropertySchema(
      id: 3,
      name: r'rainfallZScore',
      type: IsarType.double,
    ),
    r'soilMoistureValue': PropertySchema(
      id: 4,
      name: r'soilMoistureValue',
      type: IsarType.double,
    ),
    r'soilMoistureZScore': PropertySchema(
      id: 5,
      name: r'soilMoistureZScore',
      type: IsarType.double,
    ),
    r'state': PropertySchema(
      id: 6,
      name: r'state',
      type: IsarType.string,
    )
  },
  estimateSize: _anomalyResultEstimateSize,
  serialize: _anomalyResultSerialize,
  deserialize: _anomalyResultDeserialize,
  deserializeProp: _anomalyResultDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _anomalyResultGetId,
  getLinks: _anomalyResultGetLinks,
  attach: _anomalyResultAttach,
  version: '3.1.0+1',
);

int _anomalyResultEstimateSize(
  AnomalyResult object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.methodology.length * 3;
  bytesCount += 3 + object.state.length * 3;
  return bytesCount;
}

void _anomalyResultSerialize(
  AnomalyResult object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.evaluatedAt);
  writer.writeString(offsets[1], object.methodology);
  writer.writeDouble(offsets[2], object.rainfallValue);
  writer.writeDouble(offsets[3], object.rainfallZScore);
  writer.writeDouble(offsets[4], object.soilMoistureValue);
  writer.writeDouble(offsets[5], object.soilMoistureZScore);
  writer.writeString(offsets[6], object.state);
}

AnomalyResult _anomalyResultDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AnomalyResult();
  object.evaluatedAt = reader.readDateTime(offsets[0]);
  object.id = id;
  object.methodology = reader.readString(offsets[1]);
  object.rainfallValue = reader.readDouble(offsets[2]);
  object.rainfallZScore = reader.readDouble(offsets[3]);
  object.soilMoistureValue = reader.readDouble(offsets[4]);
  object.soilMoistureZScore = reader.readDouble(offsets[5]);
  object.state = reader.readString(offsets[6]);
  return object;
}

P _anomalyResultDeserializeProp<P>(
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
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _anomalyResultGetId(AnomalyResult object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _anomalyResultGetLinks(AnomalyResult object) {
  return [];
}

void _anomalyResultAttach(
    IsarCollection<dynamic> col, Id id, AnomalyResult object) {
  object.id = id;
}

extension AnomalyResultQueryWhereSort
    on QueryBuilder<AnomalyResult, AnomalyResult, QWhere> {
  QueryBuilder<AnomalyResult, AnomalyResult, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AnomalyResultQueryWhere
    on QueryBuilder<AnomalyResult, AnomalyResult, QWhereClause> {
  QueryBuilder<AnomalyResult, AnomalyResult, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AnomalyResultQueryFilter
    on QueryBuilder<AnomalyResult, AnomalyResult, QFilterCondition> {
  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      evaluatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'evaluatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      evaluatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'evaluatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      evaluatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'evaluatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      evaluatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'evaluatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'methodology',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'methodology',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'methodology',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'methodology',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'methodology',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'methodology',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'methodology',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'methodology',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'methodology',
        value: '',
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      methodologyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'methodology',
        value: '',
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rainfallValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rainfallValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rainfallValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rainfallValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallZScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rainfallZScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallZScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rainfallZScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallZScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rainfallZScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      rainfallZScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rainfallZScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureValueEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilMoistureValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureValueGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilMoistureValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureValueLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilMoistureValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureValueBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilMoistureValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureZScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soilMoistureZScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureZScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'soilMoistureZScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureZScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'soilMoistureZScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      soilMoistureZScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'soilMoistureZScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterFilterCondition>
      stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }
}

extension AnomalyResultQueryObject
    on QueryBuilder<AnomalyResult, AnomalyResult, QFilterCondition> {}

extension AnomalyResultQueryLinks
    on QueryBuilder<AnomalyResult, AnomalyResult, QFilterCondition> {}

extension AnomalyResultQuerySortBy
    on QueryBuilder<AnomalyResult, AnomalyResult, QSortBy> {
  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> sortByEvaluatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluatedAt', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortByEvaluatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluatedAt', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> sortByMethodology() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodology', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortByMethodologyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodology', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortByRainfallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallValue', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortByRainfallValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallValue', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortByRainfallZScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallZScore', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortByRainfallZScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallZScore', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortBySoilMoistureValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureValue', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortBySoilMoistureValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureValue', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortBySoilMoistureZScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureZScore', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      sortBySoilMoistureZScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureZScore', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension AnomalyResultQuerySortThenBy
    on QueryBuilder<AnomalyResult, AnomalyResult, QSortThenBy> {
  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> thenByEvaluatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluatedAt', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenByEvaluatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evaluatedAt', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> thenByMethodology() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodology', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenByMethodologyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodology', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenByRainfallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallValue', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenByRainfallValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallValue', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenByRainfallZScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallZScore', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenByRainfallZScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rainfallZScore', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenBySoilMoistureValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureValue', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenBySoilMoistureValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureValue', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenBySoilMoistureZScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureZScore', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy>
      thenBySoilMoistureZScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soilMoistureZScore', Sort.desc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QAfterSortBy> thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension AnomalyResultQueryWhereDistinct
    on QueryBuilder<AnomalyResult, AnomalyResult, QDistinct> {
  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct>
      distinctByEvaluatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'evaluatedAt');
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct> distinctByMethodology(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'methodology', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct>
      distinctByRainfallValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rainfallValue');
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct>
      distinctByRainfallZScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rainfallZScore');
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct>
      distinctBySoilMoistureValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilMoistureValue');
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct>
      distinctBySoilMoistureZScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soilMoistureZScore');
    });
  }

  QueryBuilder<AnomalyResult, AnomalyResult, QDistinct> distinctByState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }
}

extension AnomalyResultQueryProperty
    on QueryBuilder<AnomalyResult, AnomalyResult, QQueryProperty> {
  QueryBuilder<AnomalyResult, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AnomalyResult, DateTime, QQueryOperations>
      evaluatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'evaluatedAt');
    });
  }

  QueryBuilder<AnomalyResult, String, QQueryOperations> methodologyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'methodology');
    });
  }

  QueryBuilder<AnomalyResult, double, QQueryOperations>
      rainfallValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rainfallValue');
    });
  }

  QueryBuilder<AnomalyResult, double, QQueryOperations>
      rainfallZScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rainfallZScore');
    });
  }

  QueryBuilder<AnomalyResult, double, QQueryOperations>
      soilMoistureValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilMoistureValue');
    });
  }

  QueryBuilder<AnomalyResult, double, QQueryOperations>
      soilMoistureZScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soilMoistureZScore');
    });
  }

  QueryBuilder<AnomalyResult, String, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSosQueueMessageCollection on Isar {
  IsarCollection<SosQueueMessage> get sosQueueMessages => this.collection();
}

const SosQueueMessageSchema = CollectionSchema(
  name: r'SosQueueMessage',
  id: 7369799037541087222,
  properties: {
    r'battery': PropertySchema(
      id: 0,
      name: r'battery',
      type: IsarType.long,
    ),
    r'deviceId': PropertySchema(
      id: 1,
      name: r'deviceId',
      type: IsarType.string,
    ),
    r'distressType': PropertySchema(
      id: 2,
      name: r'distressType',
      type: IsarType.long,
    ),
    r'isDelivered': PropertySchema(
      id: 3,
      name: r'isDelivered',
      type: IsarType.bool,
    ),
    r'lastAttemptAt': PropertySchema(
      id: 4,
      name: r'lastAttemptAt',
      type: IsarType.dateTime,
    ),
    r'lastError': PropertySchema(
      id: 5,
      name: r'lastError',
      type: IsarType.string,
    ),
    r'latitude': PropertySchema(
      id: 6,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'longitude': PropertySchema(
      id: 7,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'meshHops': PropertySchema(
      id: 8,
      name: r'meshHops',
      type: IsarType.long,
    ),
    r'message': PropertySchema(
      id: 9,
      name: r'message',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 10,
      name: r'name',
      type: IsarType.string,
    ),
    r'peopleTrapped': PropertySchema(
      id: 11,
      name: r'peopleTrapped',
      type: IsarType.long,
    ),
    r'phone': PropertySchema(
      id: 12,
      name: r'phone',
      type: IsarType.string,
    ),
    r'senderId': PropertySchema(
      id: 13,
      name: r'senderId',
      type: IsarType.string,
    ),
    r'sosId': PropertySchema(
      id: 14,
      name: r'sosId',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 15,
      name: r'timestamp',
      type: IsarType.dateTime,
    ),
    r'ttl': PropertySchema(
      id: 16,
      name: r'ttl',
      type: IsarType.long,
    ),
    r'uploadAttempts': PropertySchema(
      id: 17,
      name: r'uploadAttempts',
      type: IsarType.long,
    )
  },
  estimateSize: _sosQueueMessageEstimateSize,
  serialize: _sosQueueMessageSerialize,
  deserialize: _sosQueueMessageDeserialize,
  deserializeProp: _sosQueueMessageDeserializeProp,
  idName: r'id',
  indexes: {
    r'sosId': IndexSchema(
      id: 1566708913025480535,
      name: r'sosId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'sosId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _sosQueueMessageGetId,
  getLinks: _sosQueueMessageGetLinks,
  attach: _sosQueueMessageAttach,
  version: '3.1.0+1',
);

int _sosQueueMessageEstimateSize(
  SosQueueMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.deviceId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lastError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.senderId.length * 3;
  bytesCount += 3 + object.sosId.length * 3;
  return bytesCount;
}

void _sosQueueMessageSerialize(
  SosQueueMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.battery);
  writer.writeString(offsets[1], object.deviceId);
  writer.writeLong(offsets[2], object.distressType);
  writer.writeBool(offsets[3], object.isDelivered);
  writer.writeDateTime(offsets[4], object.lastAttemptAt);
  writer.writeString(offsets[5], object.lastError);
  writer.writeDouble(offsets[6], object.latitude);
  writer.writeDouble(offsets[7], object.longitude);
  writer.writeLong(offsets[8], object.meshHops);
  writer.writeString(offsets[9], object.message);
  writer.writeString(offsets[10], object.name);
  writer.writeLong(offsets[11], object.peopleTrapped);
  writer.writeString(offsets[12], object.phone);
  writer.writeString(offsets[13], object.senderId);
  writer.writeString(offsets[14], object.sosId);
  writer.writeDateTime(offsets[15], object.timestamp);
  writer.writeLong(offsets[16], object.ttl);
  writer.writeLong(offsets[17], object.uploadAttempts);
}

SosQueueMessage _sosQueueMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SosQueueMessage();
  object.battery = reader.readLong(offsets[0]);
  object.deviceId = reader.readStringOrNull(offsets[1]);
  object.distressType = reader.readLong(offsets[2]);
  object.id = id;
  object.isDelivered = reader.readBool(offsets[3]);
  object.lastAttemptAt = reader.readDateTimeOrNull(offsets[4]);
  object.lastError = reader.readStringOrNull(offsets[5]);
  object.latitude = reader.readDouble(offsets[6]);
  object.longitude = reader.readDouble(offsets[7]);
  object.meshHops = reader.readLong(offsets[8]);
  object.message = reader.readStringOrNull(offsets[9]);
  object.name = reader.readStringOrNull(offsets[10]);
  object.peopleTrapped = reader.readLong(offsets[11]);
  object.phone = reader.readStringOrNull(offsets[12]);
  object.senderId = reader.readString(offsets[13]);
  object.sosId = reader.readString(offsets[14]);
  object.timestamp = reader.readDateTime(offsets[15]);
  object.ttl = reader.readLong(offsets[16]);
  object.uploadAttempts = reader.readLong(offsets[17]);
  return object;
}

P _sosQueueMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sosQueueMessageGetId(SosQueueMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sosQueueMessageGetLinks(SosQueueMessage object) {
  return [];
}

void _sosQueueMessageAttach(
    IsarCollection<dynamic> col, Id id, SosQueueMessage object) {
  object.id = id;
}

extension SosQueueMessageByIndex on IsarCollection<SosQueueMessage> {
  Future<SosQueueMessage?> getBySosId(String sosId) {
    return getByIndex(r'sosId', [sosId]);
  }

  SosQueueMessage? getBySosIdSync(String sosId) {
    return getByIndexSync(r'sosId', [sosId]);
  }

  Future<bool> deleteBySosId(String sosId) {
    return deleteByIndex(r'sosId', [sosId]);
  }

  bool deleteBySosIdSync(String sosId) {
    return deleteByIndexSync(r'sosId', [sosId]);
  }

  Future<List<SosQueueMessage?>> getAllBySosId(List<String> sosIdValues) {
    final values = sosIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'sosId', values);
  }

  List<SosQueueMessage?> getAllBySosIdSync(List<String> sosIdValues) {
    final values = sosIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'sosId', values);
  }

  Future<int> deleteAllBySosId(List<String> sosIdValues) {
    final values = sosIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'sosId', values);
  }

  int deleteAllBySosIdSync(List<String> sosIdValues) {
    final values = sosIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'sosId', values);
  }

  Future<Id> putBySosId(SosQueueMessage object) {
    return putByIndex(r'sosId', object);
  }

  Id putBySosIdSync(SosQueueMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'sosId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySosId(List<SosQueueMessage> objects) {
    return putAllByIndex(r'sosId', objects);
  }

  List<Id> putAllBySosIdSync(List<SosQueueMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'sosId', objects, saveLinks: saveLinks);
  }
}

extension SosQueueMessageQueryWhereSort
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QWhere> {
  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SosQueueMessageQueryWhere
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QWhereClause> {
  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause>
      sosIdEqualTo(String sosId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sosId',
        value: [sosId],
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterWhereClause>
      sosIdNotEqualTo(String sosId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sosId',
              lower: [],
              upper: [sosId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sosId',
              lower: [sosId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sosId',
              lower: [sosId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sosId',
              lower: [],
              upper: [sosId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension SosQueueMessageQueryFilter
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QFilterCondition> {
  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      batteryEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'battery',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      batteryGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'battery',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      batteryLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'battery',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      batteryBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'battery',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deviceId',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deviceId',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deviceId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deviceId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deviceId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      deviceIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deviceId',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      distressTypeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distressType',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      distressTypeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distressType',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      distressTypeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distressType',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      distressTypeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distressType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      isDeliveredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDelivered',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastAttemptAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastAttemptAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastAttemptAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastAttemptAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastAttemptAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastAttemptAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastError',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastError',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastError',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastError',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      lastErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastError',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      meshHopsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meshHops',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      meshHopsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meshHops',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      meshHopsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meshHops',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      meshHopsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meshHops',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      peopleTrappedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peopleTrapped',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      peopleTrappedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peopleTrapped',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      peopleTrappedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peopleTrapped',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      peopleTrappedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peopleTrapped',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      senderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sosId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sosId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sosId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sosId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sosId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sosId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sosId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sosId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sosId',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      sosIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sosId',
        value: '',
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      ttlEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ttl',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      ttlGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ttl',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      ttlLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ttl',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      ttlBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ttl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      uploadAttemptsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uploadAttempts',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      uploadAttemptsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uploadAttempts',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      uploadAttemptsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uploadAttempts',
        value: value,
      ));
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterFilterCondition>
      uploadAttemptsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uploadAttempts',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SosQueueMessageQueryObject
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QFilterCondition> {}

extension SosQueueMessageQueryLinks
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QFilterCondition> {}

extension SosQueueMessageQuerySortBy
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QSortBy> {
  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortByBattery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'battery', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByBatteryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'battery', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByDistressType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distressType', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByDistressTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distressType', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByIsDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByIsDeliveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByMeshHops() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshHops', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByMeshHopsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshHops', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByPeopleTrapped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleTrapped', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByPeopleTrappedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleTrapped', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortBySosId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosId', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortBySosIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosId', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortByTtl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttl', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> sortByTtlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttl', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByUploadAttempts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadAttempts', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      sortByUploadAttemptsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadAttempts', Sort.desc);
    });
  }
}

extension SosQueueMessageQuerySortThenBy
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QSortThenBy> {
  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByBattery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'battery', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByBatteryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'battery', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByDeviceId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByDeviceIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deviceId', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByDistressType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distressType', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByDistressTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distressType', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByIsDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByIsDeliveredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDelivered', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByMeshHops() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshHops', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByMeshHopsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meshHops', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByPeopleTrapped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleTrapped', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByPeopleTrappedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleTrapped', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenBySosId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosId', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenBySosIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sosId', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByTtl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttl', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy> thenByTtlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ttl', Sort.desc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByUploadAttempts() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadAttempts', Sort.asc);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QAfterSortBy>
      thenByUploadAttemptsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uploadAttempts', Sort.desc);
    });
  }
}

extension SosQueueMessageQueryWhereDistinct
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> {
  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByBattery() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'battery');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctByDeviceId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deviceId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByDistressType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distressType');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByIsDelivered() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDelivered');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptAt');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctByLastError(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByMeshHops() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meshHops');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByPeopleTrapped() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peopleTrapped');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctBySenderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctBySosId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sosId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct> distinctByTtl() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ttl');
    });
  }

  QueryBuilder<SosQueueMessage, SosQueueMessage, QDistinct>
      distinctByUploadAttempts() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uploadAttempts');
    });
  }
}

extension SosQueueMessageQueryProperty
    on QueryBuilder<SosQueueMessage, SosQueueMessage, QQueryProperty> {
  QueryBuilder<SosQueueMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SosQueueMessage, int, QQueryOperations> batteryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'battery');
    });
  }

  QueryBuilder<SosQueueMessage, String?, QQueryOperations> deviceIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deviceId');
    });
  }

  QueryBuilder<SosQueueMessage, int, QQueryOperations> distressTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distressType');
    });
  }

  QueryBuilder<SosQueueMessage, bool, QQueryOperations> isDeliveredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDelivered');
    });
  }

  QueryBuilder<SosQueueMessage, DateTime?, QQueryOperations>
      lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptAt');
    });
  }

  QueryBuilder<SosQueueMessage, String?, QQueryOperations> lastErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastError');
    });
  }

  QueryBuilder<SosQueueMessage, double, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<SosQueueMessage, double, QQueryOperations> longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<SosQueueMessage, int, QQueryOperations> meshHopsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meshHops');
    });
  }

  QueryBuilder<SosQueueMessage, String?, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<SosQueueMessage, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SosQueueMessage, int, QQueryOperations> peopleTrappedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peopleTrapped');
    });
  }

  QueryBuilder<SosQueueMessage, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<SosQueueMessage, String, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<SosQueueMessage, String, QQueryOperations> sosIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sosId');
    });
  }

  QueryBuilder<SosQueueMessage, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<SosQueueMessage, int, QQueryOperations> ttlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ttl');
    });
  }

  QueryBuilder<SosQueueMessage, int, QQueryOperations>
      uploadAttemptsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uploadAttempts');
    });
  }
}
