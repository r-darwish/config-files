export def list-items [] {
    op item list --format json | from json | each { |item|
        return {
            name: $item.title
            vault: $item.vault.name
            category: $item.category
            created: ($item.created_at | into datetime)
            updated: ($item.updated_at | into datetime)
        }
    }
}

export def read-item [id: string] {
    let record = op item get --reveal --format json $id | from json
    if $record == null {
        return null
    }

    mut result = {
        name : $record.title
        category: $record.category
        created: ($record.created_at | into datetime)
        updated: ($record.updated_at | into datetime)
        version: $record.version
    }

    for value in $record.fields {
        $result = $result | insert $value.id $value.value?
    }

    return $result
}
