# DNS TXT Record Verification Tool

A cross-platform command-line application to verify DNS TXT records. Works on macOS, Windows, and Linux.

## Features

- ✅ Verify TXT record existence
- ✅ Compare actual vs expected values
- ✅ Support for multiple TXT records on the same domain
- ✅ Clear success/failure reporting
- ✅ Detailed error messages
- ✅ Cross-platform (macOS, Windows, Linux)

## Installation

### Prerequisites

- Python 3.6 or higher

### Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Make the script executable (macOS/Linux):
```bash
chmod +x verify_txt_record.py
```

## Usage

### Basic Usage

```bash
python verify_txt_record.py <record_name> <expected_value>
```

### Examples

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

### Options

- `-v, --verbose`: Show all TXT records found, even if verification succeeds
- `--version`: Show version information
- `-h, --help`: Show help message

### Verbose Mode

```bash
python verify_txt_record.py example.com "expected value" --verbose
```

## Exit Codes

- `0`: Verification successful (TXT record exists and matches expected value)
- `1`: Verification failed (record not found, value mismatch, or DNS error)

## Output Examples

### Success

```
Verifying TXT record for: example.com
------------------------------------------------------------
✓ TXT record verified successfully
  Record: example.com
  Value: v=spf1 include:_spf.google.com ~all
------------------------------------------------------------
```

### Value Mismatch

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

### Domain Not Found

```
Verifying TXT record for: nonexistent.example.com
------------------------------------------------------------
✗ Verification failed: Domain 'nonexistent.example.com' does not exist
------------------------------------------------------------
```

## Testing

Test with a known TXT record:

```bash
# Google's public DNS TXT record
python verify_txt_record.py google.com "v=spf1 include:_spf.google.com ~all"
```

## Platform-Specific Notes

### macOS
- Works natively with system Python or installed Python 3
- Uses system DNS resolver by default

### Windows
- Works with Python 3 from python.org or Microsoft Store
- Uses system DNS resolver by default

### Linux
- Works with system Python 3 or virtual environments
- Uses system DNS resolver by default

## Troubleshooting

**DNS timeout errors**: The tool waits up to 10 seconds for DNS responses. If you experience timeouts:
- Check your internet connection
- Verify DNS servers are accessible
- Try using a public DNS server (configure in OS settings)

**Import errors**: Make sure `dnspython` is installed:
```bash
pip install dnspython
```

**Permission errors on Unix systems**: Make the script executable:
```bash
chmod +x verify_txt_record.py
```

## License

MIT License - feel free to use and modify as needed.
