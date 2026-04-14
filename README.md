# Scripts

Collection of tools and scripts for various tasks

## Tools

### DNS TXT Record Verification Tool

A cross-platform command-line application to verify DNS TXT records. Works on macOS, Windows, and Linux.

#### Features

- ✅ Verify TXT record existence
- ✅ Compare actual vs expected values
- ✅ Support for multiple TXT records on the same domain
- ✅ Clear success/failure reporting
- ✅ Detailed error messages
- ✅ Cross-platform (macOS, Windows, Linux)

#### Installation

**Prerequisites:** Python 3.6 or higher

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Make the script executable (macOS/Linux):
```bash
chmod +x verify_txt_record.py
```

#### Usage

**Basic Usage:**
```bash
python verify_txt_record.py <record_name> <expected_value>
```

**Examples:**

Verify an SPF record:
```bash
python verify_txt_record.py example.com "v=spf1 include:_spf.google.com ~all"
```

Verify a DMARC record:
```bash
python verify_txt_record.py _dmarc.example.com "v=DMARC1; p=reject;"
```

Verify a domain verification record:
```bash
python verify_txt_record.py verification.example.com "google-site-verification=ABC123"
```

**Options:**
- `-v, --verbose`: Show all TXT records found, even if verification succeeds
- `--version`: Show version information
- `-h, --help`: Show help message

#### Exit Codes

- `0`: Verification successful (TXT record exists and matches expected value)
- `1`: Verification failed (record not found, value mismatch, or DNS error)

#### Output Examples

**Success:**
```
Verifying TXT record for: example.com
------------------------------------------------------------
✓ TXT record verified successfully
  Record: example.com
  Value: v=spf1 include:_spf.google.com ~all
------------------------------------------------------------
```

**Value Mismatch:**
```
Verifying TXT record for: example.com
------------------------------------------------------------
✗ TXT record value mismatch
  Record: example.com
  Expected: v=spf1 wrong-value
  Found:
    [1] v=spf1 include:_spf.google.com ~all
------------------------------------------------------------
```

**Domain Not Found:**
```
Verifying TXT record for: nonexistent.example.com
------------------------------------------------------------
✗ Verification failed: Domain 'nonexistent.example.com' does not exist
------------------------------------------------------------
```

## License

Apache License 2.0
